class AddPrivateToDiscussions < ActiveRecord::Migration[5.2]
  def change
    add_column :discussions, :private, :boolean
  end
end
