class AddMaterialLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :material_logs do |t|
      t.references :material
      t.references :user
      t.string :method
      t.integer :quantity
      t.timestamps
    end
  end
end
