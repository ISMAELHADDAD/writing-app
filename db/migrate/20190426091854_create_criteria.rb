class CreateCriteria < ActiveRecord::Migration[5.2]
  def change
    create_table :criteria do |t|
      t.string :text
      t.references :discussion, foreign_key: true

      t.timestamps
    end
  end
end
