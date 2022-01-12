class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.integer :mode
      t.datetime :release_date
      t.string :developer
      t.references :system_requirements, null: false, foreign_key: true

      t.timestamps
    end
  end
end
