# frozen_string_literal: true

module RailsServerMonitor
  class Engine < ::Rails::Engine
    isolate_namespace RailsServerMonitor

    config.app_middleware.use(
      Rack::Static,
      urls: ["/rails-server-monitor-packs"], root: RailsServerMonitor::Engine.root.join("public").to_s
    )
  end
end
