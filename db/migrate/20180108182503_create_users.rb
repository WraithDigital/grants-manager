class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string  :email,           null: false
      t.string  :password_digest, null: false
      t.boolean :admin,           null: false, default: false

      t.timestamps
    end

    add_index :users, :email
  end
end
