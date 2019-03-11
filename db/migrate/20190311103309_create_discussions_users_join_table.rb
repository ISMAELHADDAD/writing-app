class CreateDiscussionsUsersJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :participants do |t|
      t.references :discussion, foreign_key: true
      t.references :user, foreign_key: true
      t.string :token
      t.boolean :verified

      t.timestamps
    end
  end
end
