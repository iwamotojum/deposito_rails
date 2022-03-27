class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :materials do |t|
      t.string :name, unique: true
      t.string :description
      t.integer :quantity
      t.timestamps
    end
  end
end
