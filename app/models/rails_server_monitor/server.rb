# frozen_string_literal: true

module RailsServerMonitor
  class Server < ApplicationRecord
    self.table_name = "rails_server_monitor_servers"
  end
end
