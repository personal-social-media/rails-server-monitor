# frozen_string_literal: true

module RailsServerMonitor
  class ServersController < ApplicationController
    before_action :require_current_server, only: %i(show update)

    def show
      @server = current_server
      @chart = RailsServerMonitor::ChartForServer.new(@server, timeline: params[:timeline])

      @title = @server.display_name
    end

    def update
      update_params = params.require(:server).permit(:custom_name, :custom_description)
      current_server.update!(update_params)
      redirect_to server_path(current_server)

    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: 422
    end

    def current_server
      @current_server ||= RailsServerMonitor::Server.find_by(id: params[:id])
    end

    def require_current_server
      redirect_to root_path, notice: "Server not found" if current_server.blank?
    end
  end
end
