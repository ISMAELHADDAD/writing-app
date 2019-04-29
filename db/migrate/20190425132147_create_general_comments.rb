class CreateGeneralComments < ActiveRecord::Migration[5.2]
  def change
    create_table :general_comments do |t|
      t.string :text
      t.references :user, foreign_key: true
      t.references :discussion, foreign_key: true

      t.timestamps
    end
  end
end
