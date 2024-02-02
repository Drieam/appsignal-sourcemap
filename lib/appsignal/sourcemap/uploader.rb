# frozen_string_literal: true

module Appsignal
  module Sourcemap
    class Uploader
      UPLOAD_URI = URI("https://appsignal.com/api/sourcemaps")

      def self.upload(sourcemap_path)
        new(sourcemap_path).upload
      end

      def initialize(sourcemap_path)
        @sourcemap_path = sourcemap_path
      end

      def upload
        Rails.logger.debug("Starting sourcemap upload '#{@sourcemap_path}' with parameters: #{request_form_data}")

        response = Net::HTTP.start(UPLOAD_URI.hostname, UPLOAD_URI.port, use_ssl: true) do |http|
          http.request(request)
        end

        if response.is_a?(Net::HTTPSuccess)
          Rails.logger.debug("Finished sourcemap upload '#{@sourcemap_path}'")
          File.delete(sourcemap_full_path)
          return
        end

        Rails.logger.error <<~MESSAGE
          Uploading sourcemap #{@sourcemap_path} failed with message '#{response.message}'.
            Response: #{response.body}
        MESSAGE
      end

      private

      def sourcemap_full_path
        Rails.public_path.join(@sourcemap_path)
      end

      def request
        Net::HTTP::Post.new(UPLOAD_URI).tap do |request|
          request.set_form request_form_data, "multipart/form-data"
        end
      end

      def request_form_data
        [
          ["push_api_key", Appsignal.config[:push_api_key]],
          ["app_name", Appsignal.config[:name]],
          ["revision", Appsignal.config[:revision]],
          ["environment", Appsignal.config.env],
          ["name[]", source_url],
          ["file", sourcemap_content]
        ]
      end

      def sourcemap_content
        File.open(Rails.public_path.join(@sourcemap_path))
      end

      def source_url
        "#{asset_host}/#{js_path}"
      end

      def js_path
        @sourcemap_path.delete_suffix(".map")
      end

      def asset_host
        Rails.application.config.asset_host
      end
    end
  end
end
