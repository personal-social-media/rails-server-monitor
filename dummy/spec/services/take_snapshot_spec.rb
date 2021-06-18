# frozen_string_literal: true

require "rails_helper"

RSpec.describe RailsServerMonitor::ServerSetup do
  subject do
    described_class.new.call
  end

  it "creates a server" do
    expect do
      subject
    end.to change { RailsServerMonitor::Server.count }.by(1)
  end
end
