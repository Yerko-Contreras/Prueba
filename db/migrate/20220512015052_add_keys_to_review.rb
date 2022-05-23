class AddKeysToReview < ActiveRecord::Migration[6.0]
  def change
    change_table(:reviews) do |t|
        add_reference :reviews, :user, null: false, foreign_key: true
        t.references :receiver, foreign_key: { to_table: 'users' }
    end
  end
end
