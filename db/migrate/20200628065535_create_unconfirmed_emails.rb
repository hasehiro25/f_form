class CreateUnconfirmedEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :unconfirmed_emails do |t|
      t.references :user, foreign_key: true, null: false, index: {unique: true}
      t.string :email, null: false, index: true
      t.string :encoded_token, null: false, index: {unique: true}
      t.timestamps
    end
  end
end
