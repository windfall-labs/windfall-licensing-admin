class CreateImportedStores < ActiveRecord::Migration[5.0]
  def change
    create_table :imported_stores do |t|
      t.boolean :imported, default: false

      t.timestamps
    end
  end
end
