# frozen_string_literal: true

module RailsServerMonitor
  class ServerGroup < ApplicationRecord
    self.table_name = "rails_server_monitor_server_groups"

    has_many :servers, class_name: "RailsServerMonitor::Server", dependent: :nullify
    validates :name, presence: true, uniqueness: true
  end
end
