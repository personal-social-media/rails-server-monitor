# frozen_string_literal: true

require "rails_helper"

RSpec.describe RailsServerMonitor::TakeSnapshot do
  let(:server) { create(:server) }
  subject do
    described_class.new(server).call
  end

  it "takes a snapshot" do
    expect do
      subject
    end.to change { RailsServerMonitor::ServerSnapshot.count }.by(1)
  end
end
