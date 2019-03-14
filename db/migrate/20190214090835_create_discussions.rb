class CreateDiscussions < ActiveRecord::Migration[5.2]
  def change
    create_table :discussions do |t|
      t.string :topic_title
      t.string :topic_description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
