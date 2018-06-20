class CreateDriftmaps < ActiveRecord::Migration[5.2]
  def change
    create_table :driftmaps do |t|
      t.float :lat
      t.float :lng
      t.integer :zoom
      t.references :user, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
