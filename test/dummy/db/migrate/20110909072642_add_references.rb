class AddReferences < ActiveRecord::Migration
  def up
    add_foreign_key(:books, :users, :column => 'user_id')
  end

  def down
    change_table :books do |t|
      t.remove_foreign_key :users
    end
  end
end
