# frozen_string_literal: true

require 'appsignal/hooks'

module Appsignal
  module Sourcemap
    class SourcemapHook < Appsignal::Hooks::Hook
      register :sourcemap

      def dependencies_present?
        defined?(::Rails) &&
          defined?(::Rake::Task) &&
          Rake::Task.task_defined?('assets:precompile') &&
          Appsignal.config &&
          Appsignal.config[:upload_sourcemaps]
      end

      def install
        require 'appsignal/sourcemap/supervisor'

        Rake::Task['assets:precompile'].enhance do
          Appsignal::Sourcemap::Supervisor.start
        end
      end
    end
  end
end
