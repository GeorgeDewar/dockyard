class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name

      t.string :repo_uri
      t.string :docker_uri

      t.boolean :initialised, default: false

      t.timestamps
    end
  end
end
