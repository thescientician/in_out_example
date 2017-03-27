class AddStatusAndNamesToUsers < ActiveRecord::Migration

  def change
    change_table :users do |t|
      t.integer :status,    :default => 0
      t.string :first_name, :length => 255
      t.string :last_name,  :length => 255
    end
  end
end
