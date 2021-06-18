# frozen_string_literal: true

module RailsServerMonitor
  class RackMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      request = ActionDispatch::Request.new(env)
      return @app.call(request.env) if ignore_request?(request)

      server = RailsServerMonitor::ServerSetup.new.call
      snapshot = RailsServerMonitor::TakeSnapshot.new(server)

      if snapshot.can_take_snapshot?
        snapshot.call

        RailsServerMonitor::Cleanup.new.call
      end

      @app.call(request.env)
    end

    def ignore_request?(request)
      return false if config.ignore_urls.blank?

      path = request.path
      return true if config.ignore_urls.detect do |url|
        if url.is_a?(String)
          next path.include?(path)
        elsif url.is_a?(Regexp)
          next url.match?(path)
        end
      end.present?

      false
    end

    def config
      RailsServerMonitor.config
    end
  end
end
