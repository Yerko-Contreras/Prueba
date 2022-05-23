class AddKeysToRequest < ActiveRecord::Migration[6.0]
  def change
    change_table(:requests) do |t|
        add_reference :requests, :user, null: false, foreign_key: true
        t.references :turno
    end
  end
end
