class ConvertStringIpsToIntegers < ActiveRecord::Migration
  # This is the only way to accomplish this task.
  # If you were using MySQL you could get away with INET_ATOI and INET_ITOA, but I'm using sqlite which 


  def up
    
    vals = execute("SELECT id, current_sign_in_ip, last_sign_in_ip from USERS;")
    vals.each do |user|
      current_sign_in_ip = user["current_sign_in_ip"] || 0
      last_sign_in_ip = user["last_sign_in_ip"] || 0
      user_id = user["id"]
      execute("UPDATE users set current_sign_in_ip = #{current_sign_in_ip.inet_atoi}, last_sign_in_ip = #{last_sign_in_ip.inet_atoi } where id = #{user_id};")
    end
    change_column :users, :current_sign_in_ip, :integer
    change_column :users, :last_sign_in_ip, :integer
  end

  def down

    vals = execute("SELECT id, current_sign_in_ip, last_sign_in_ip from USERS;")
    vals.each do |user|
      current_sign_in_ip = user["current_sign_in_ip"] || 0
      last_sign_in_ip = user["last_sign_in_ip"] || 0
      user_id = user["id"]
      execute("UPDATE users set current_sign_in_ip = '#{current_sign_in_ip.inet_itoa}', last_sign_in_ip = '#{last_sign_in_ip.inet_itoa }' where id = #{user_id};")
    end
    change_column :users, :current_sign_in_ip, :string
    change_column :users, :last_sign_in_ip,    :string
  end
end
