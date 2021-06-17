# frozen_string_literal: true

module RailsServerMonitor
  class Engine < ::Rails::Engine
    isolate_namespace RailsServerMonitor

    p "CALLED3"
    p RailsServerMonitor::Engine.root.join("public").to_s

    config.app_middleware.use(
      Rack::Static,
      # note! this varies from the Webpacker/engine documentation
      urls: ["/rails-server-monitor-packs"], root: RailsServerMonitor::Engine.root.join("public").to_s
      # instead of -> urls: ["/saddlebag-packs"], root: "saddlebag/public"
    )
  end
end
