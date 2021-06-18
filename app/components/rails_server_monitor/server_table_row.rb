module RailsServerMonitor
  class ServerTableRow < ViewComponent::Base
    attr_reader :title, :value
    def initialize(title:, value:)
      @title = title
      @value = value
    end
  end
end