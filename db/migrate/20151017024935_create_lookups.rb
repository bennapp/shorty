class CreateLookups < ActiveRecord::Migration
  def change
    create_table :lookups do |t|
      t.string :token
      t.string :url

      t.timestamps
    end
  end
end
