module RailsServerMonitor
  class LeftbarComponent < ViewComponent::Base
    attr_reader :ctx
    def initialize(ctx:)
      @ctx = ctx
    end

    def groups
      @groups ||= RailsServerMonitor::ServerGroup.order(name: :asc).all
    end

    def servers
      @servers ||= RailsServerMonitor::Server.all.sort_by(&:display_name)
    end
  end
end