# frozen_string_literal: true

require "appsignal/sourcemap/uploader"

module Appsignal
  module Sourcemap
    class Supervisor
      def self.start
        new.start
      end

      def start
        return if invalid_preconditions

        Appsignal.logger.info("Starting sourcemaps upload")

        source_map_paths.map do |source_map_path|
          Thread.new do
            Uploader.upload(source_map_path)
          end
        end.each(&:join)

        Appsignal.logger.info("Finished sourcemaps upload")
      end

      private

      def invalid_preconditions
        unless Appsignal.config.valid?
          return Appsignal.logger.error("Skipping sourcemaps upload since Appsignal config is invalid")
        end
        if asset_host.blank?
          return Appsignal.logger.error("Skipping sourcemaps upload since Rails asset_host is not set")
        end
        if source_map_paths.empty?
          return Appsignal.logger.info("Skipping sourcemaps upload since no javascript maps are found")
        end

        false
      end

      def asset_host
        Rails.application.config.asset_host
      end

      def source_map_paths
        Dir.glob("**/*.map", base: Rails.public_path)
      end
    end
  end
end
