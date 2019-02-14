class CreateAvatars < ActiveRecord::Migration[5.2]
  def change
    create_table :avatars do |t|
      t.string :name
      t.text :opinion
      t.references :discussion, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
