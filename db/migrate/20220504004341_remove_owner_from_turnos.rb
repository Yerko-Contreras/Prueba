class RemoveOwnerFromTurnos < ActiveRecord::Migration[6.0]
  def change
    remove_column :turnos, :owner, :integer
  end
end
