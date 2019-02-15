class CreateDiscussions < ActiveRecord::Migration[5.2]
  def change
    create_table :discussions do |t|
      t.string :topicTitle
      t.string :topicDescription
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
