class AddIndexOnLookupsForToken < ActiveRecord::Migration
  def change
    add_index :lookups, :token
  end
end
