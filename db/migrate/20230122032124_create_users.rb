class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :stripe_token
      t.string :full_name
      t.string :contact
      t.string :country_code

      t.timestamps
    end
  end
end
