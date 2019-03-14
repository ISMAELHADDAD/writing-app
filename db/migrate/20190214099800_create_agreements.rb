class CreateAgreements < ActiveRecord::Migration[5.2]
  def change
    create_table :agreements do |t|
      t.text :content
      t.boolean :is_accepted
      t.boolean :is_agree
      t.references :avatar, foreign_key: true
      t.references :discussion, foreign_key: true

      t.timestamps
    end
  end
end
