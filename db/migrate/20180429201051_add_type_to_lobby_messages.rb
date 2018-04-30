class AddTypeToLobbyMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :lobby_messages, :messageType, :string
  end
end
