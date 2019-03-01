class AddArgumentsCountToDiscussions < ActiveRecord::Migration[5.2]
  def change
    add_column :discussions, :arguments_count, :integer
  end
end
