# frozen_string_literal: true

module ApplicationHelper
  def format_with_br(text)
    simple_format(h(text))
  end
end
