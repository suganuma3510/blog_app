class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin,   :boolean, default: false
    add_column :users, :name,    :string,  null: false, default: ""
    add_column :users, :image,   :string
    add_column :users, :profile, :string
  end
end
