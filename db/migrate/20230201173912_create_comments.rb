class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :text

      t.timestamps
    end
    add_reference :likes, :author, foreign_key: { to_table: :users }
    add_reference :likes, :post, foreign_key: true
  end
end