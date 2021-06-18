# frozen_string_literal: true

module RailsServerMonitor
  class SnapshotsController < ApplicationController
    before_action :require_current_snapshot, only: :show

    def show
      @snapshot = current_snapshot

      @title = "Snapshot - #{@snapshot.id}"
    end

    def current_snapshot
      @current_snapshot ||= RailsServerMonitor::ServerSnapshot.find_by(id: params[:id])
    end

    def require_current_snapshot
      redirect_to root_path, notice: "Server not found" if current_snapshot.blank?
    end
  end
end
