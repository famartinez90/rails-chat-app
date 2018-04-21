class AddDetailsToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :id_group, :integer
  end
end
