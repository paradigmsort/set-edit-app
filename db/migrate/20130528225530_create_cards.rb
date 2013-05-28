class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.string :cost
      t.string :type
      t.string :text
      t.integer :power
      t.integer :toughness

      t.timestamps
    end
  end
end
