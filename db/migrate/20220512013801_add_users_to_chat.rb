class AddUsersToChat < ActiveRecord::Migration[6.0]
  def change
    add_reference :chats, :user, null: false, foreign_key: true
    add_reference :chats, :turno, null: false, foreign_key: true
  end
end
