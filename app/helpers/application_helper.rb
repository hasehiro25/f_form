# frozen_string_literal: true

module ApplicationHelper
  def format_with_br(text)
    simple_format(h(text))
  end

  def endpoint_url(endpoint_id)
    if Rails.env.production?
      "#{request.protocol}#{request.host}/api/v1/forms/#{endpoint_id}"
    else
      "#{request.protocol}#{request.host_with_port}/api/v1/forms/#{endpoint_id}"
    end
  end

  def form_js_url
    if Rails.env.production?
      "#{request.protocol}#{request.host}/form_lib.js"
    else
      "#{request.protocol}#{request.host_with_port}/form_lib.js"
    end
  end
end
