class CreateArguments < ActiveRecord::Migration[5.2]
  def change
    create_table :arguments do |t|
      t.integer :num
      t.text :content
      t.datetime :publish_time
      t.references :discussion, foreign_key: true
      t.references :avatar, foreign_key: true

      t.timestamps
    end
  end
end
