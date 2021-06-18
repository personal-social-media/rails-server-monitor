# frozen_string_literal: true

FactoryBot.define do
  factory :server, class: RailsServerMonitor::Server do
    hostname { SecureRandom.hex }
  end
end
