# frozen_string_literal: true

module UrlHelper
  def endpoint_url(endpoint_id)
    "#{root_url}api/v1/forms/#{endpoint_id}"
  end

  def fform_core_js_url
    "#{root_url}fform_core.js"
  end
end
