# frozen_string_literal: true

Settings = ActiveSupport::InheritableOptions.new(Rails.application.config_for(:settings).deep_symbolize_keys)
