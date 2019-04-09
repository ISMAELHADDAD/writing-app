class AddForkedFromToDiscussions < ActiveRecord::Migration[5.2]
  def change
    add_column :discussions, :forked_from, :integer
  end
end
