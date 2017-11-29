# frozen_string_literal: true

# This is module contains custom methods for markdown renderer
module MarkdownHelpers
  require 'middleman-core/renderers/redcarpet'

  # Customizing Markdown Render
  class DSRenderer < Middleman::Renderers::MiddlemanRedcarpetHTML

    def initialize(options={})
      super
    end

    def image(link, title, alt_text)
      if !@local_options[:no_images]
        scope.content_tag(:div, class: 'image-block') do
          scope.image_tag(link, title: title, alt: alt_text)
        end
      else
        link_string = link.dup

        if title && !title.empty? && title != alt_text
          link_string << %("#{title}")
        end
        "![#{alt_text}](#{link_string})"
      end
    end
  end
end
