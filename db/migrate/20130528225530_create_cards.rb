class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.string :cost
      t.string :typeline # type is reserved for storing class in case of inheritance
      t.string :text
      t.integer :power
      t.integer :toughness

      t.timestamps
    end
  end
end
