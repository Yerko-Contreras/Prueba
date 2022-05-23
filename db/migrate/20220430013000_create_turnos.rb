class CreateTurnos < ActiveRecord::Migration[6.0]
  def change
    create_table :turnos do |t|
      t.string :address_in
      t.string :address_out
      t.integer :capacity
      t.string :route
      t.string :day
      t.string :hour
      t.integer :owner

      t.timestamps
    end
  end
end
