class AddCuposDisponiblesToTurno < ActiveRecord::Migration[6.0]
  def change
    add_column :turnos, :cupos_ocupados, :integer, :default => 0
  end
end
