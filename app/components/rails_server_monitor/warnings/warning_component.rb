# frozen_string_literal: true

module RailsServerMonitor
  module Warnings
    class WarningComponent < ViewComponent::Base
      attr_reader :ctx, :snapshot, :warning
      def initialize(ctx:, snapshot:, warning:)
        @ctx = ctx
        @snapshot = snapshot
        @warning = warning
      end
    end
  end
end
