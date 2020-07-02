# frozen_string_literal: true

class Form < ApplicationRecord
  belongs_to :user
  has_many :inquiries, dependent: :destroy

  validates :name, presence: true
  validates :domain, presence: true

  before_save :create_endpoint_id

  def create_endpoint_id
    self.endpoint_id ||= SecureRandom.uuid
  end

  def same_domain?(requested_domain)
    domain == requested_domain
  end
end
