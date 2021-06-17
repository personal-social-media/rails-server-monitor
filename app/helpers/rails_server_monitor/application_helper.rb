# frozen_string_literal: true

require "webpacker"

module RailsServerMonitor
  module ApplicationHelper
    include ::Webpacker::Helper

    def current_webpacker_instance
      RailsServerMonitor.webpacker
    end

    def safe_render_js(name, **options)
      if respond_to?(:javascript_packs_with_chunks_tag)
        return javascript_packs_with_chunks_tag(name, **options)
      end

      javascript_pack_tag(name, *options)
    end

    def safe_render_css(name, **options)
      if respond_to?(:javascript_packs_with_chunks_tag)
        return stylesheet_packs_with_chunks_tag(name, **options)
      end

      stylesheet_pack_tag(name, **options)
    end
  end
end
