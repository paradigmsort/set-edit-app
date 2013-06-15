class AddCardVersionToComment < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.integer :card_version
    end
  end
end
