require "rails_helper"

RSpec.describe RailsServerMonitor::ServerSetup do
  subject do
    described_class.new.call
  end

  it "creates a server" do
    subject
  end
end