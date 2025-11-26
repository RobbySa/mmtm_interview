class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :name
      t.integer :pages
      t.string :isbn13
      t.integer :price_pence
      t.string :currency
      t.string :tags
      t.integer :publication_year
      t.references :series, foreign_key: true
      t.integer :position

      t.timestamps
    end
    
    # Enforce uniqueness to avoid duplicates
    add_index :books, :isbn13, unique: true
  end
end
