class RemoveFieldNameFromMessages < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :to, :string
  end
end
