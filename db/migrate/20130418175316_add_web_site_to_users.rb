class AddWebSiteToUsers < ActiveRecord::Migration

  def change
    add_column :users, :web_site, :string, length:255
  end
end
