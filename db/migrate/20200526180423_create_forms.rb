# frozen_string_literal: true

class CreateForms < ActiveRecord::Migration[6.0]
  def change
    create_table :forms do |t|
      t.references :user, foreign_key: true, null: false
      t.string :name, null: false
      t.string :domain, null: false
      t.string :redirect_url
      t.string :endpoint_id, index: true

      t.timestamps
    end
  end
end
