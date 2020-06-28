# frozen_string_literal: true

class UnconfirmedEmail < ApplicationRecord
  attr_accessor :raw_token

  belongs_to :user

  before_save :create_token

  validate :uniquness_of_user_email

  def create_token
    raw, enc = token_generator.generate
    self.raw_token = raw
    self.encoded_token = enc
  end

  def valid_token?(raw_token)
    token_generator.digest(raw_token) == encoded_token
  end

  def token_generator
    @token_generator ||= TokenGenerator.new(self.class, :encoded_token)
  end

  private
    def uniquness_of_user_email
      errors.add(:email, :taken) if User.exists?(email: email)
    end
end
