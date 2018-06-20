class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.timestamps
      t.string     :first_name
      t.string 	   :last_name
      t.string	   :email, index: true, unique: true
      t.string     :password_digest
      t.string     :token
      t.text       :description

      t.timestamps
    end
    add_index :users, :token, unique: true
  end
end