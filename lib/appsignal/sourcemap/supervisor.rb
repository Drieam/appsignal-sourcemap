# frozen_string_literal: true

require "parallel"
require "appsignal/sourcemap/uploader"

module Appsignal
  module Sourcemap
    class Supervisor
      PARALLEL_THREADS = 10

      def self.start
        new.start
      end

      def start
        return if invalid_preconditions

        Rails.logger.info("Starting sourcemaps upload")

        Parallel.each(source_map_paths, in_threads: PARALLEL_THREADS) do |source_map_path|
          Uploader.upload(source_map_path)
        end

        Rails.logger.info("Finished sourcemaps upload")
      end

      private

      def invalid_preconditions
        unless Appsignal.config.valid?
          return Rails.logger.error("Skipping sourcemaps upload since Appsignal config is invalid")
        end
        if asset_host.blank?
          return Rails.logger.error("Skipping sourcemaps upload since Rails asset_host is not set")
        end
        return Rails.logger.info("Skipping sourcemaps upload since no javascript maps are found") if source_map_paths.empty?

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
