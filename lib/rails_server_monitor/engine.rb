p "CALLED"

module RailsServerMonitor
  class Engine < ::Rails::Engine
    isolate_namespace Rails::Server::Monitor
  end
end
