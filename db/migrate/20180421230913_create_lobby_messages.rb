class CreateLobbyMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :lobby_messages do |t|
      t.string :from
      t.text :content

      t.timestamps
    end
  end
end
