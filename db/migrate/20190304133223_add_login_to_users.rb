class AddLoginToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :full_name, :string
    add_column :users, :email, :string
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :session_token, :string
    add_column :users, :session_token_expires_at, :datetime
  end
end
