class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :path
      t.boolean :initialised, default: false

      t.timestamps
    end
  end
end
