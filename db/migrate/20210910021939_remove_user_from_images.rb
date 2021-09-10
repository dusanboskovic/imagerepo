class RemoveUserFromImages < ActiveRecord::Migration[6.1]
  def change
    remove_column :images, :user, :string
  end
end
