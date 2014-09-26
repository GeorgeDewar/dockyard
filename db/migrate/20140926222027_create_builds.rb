class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.references :repository, index: true
      t.string :tag
      t.text :logs
      t.string :status

      t.timestamps
    end
  end
end
