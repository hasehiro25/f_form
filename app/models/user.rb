# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  VALID_EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\Z/
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true, presence: true, format: { with: VALID_EMAIL_REGEX }

  has_many :forms, dependent: :destroy
  has_one :unconfirmed_email
end
