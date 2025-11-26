class CreateAuthorsBooksJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_table :authors_books, id: false do |t|
      t.references :author, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
    end

    # Enforce uniqueness to avoid duplicates
    add_index :authors_books, [:author_id, :book_id], unique: true
  end
end
