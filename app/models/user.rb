class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :status, :first_name, :last_name, :web_site, :team_id
  belongs_to :team

  scope :without_user, lambda {|user| where("id <> :id", :id => user.id) }

  STATUSES = {:in => 0, :out => 1}.freeze

  validates :status, :inclusion => {:in => STATUSES.keys }

  def full_name
    [first_name, last_name].join(" ")
  end

  def status=(val)    
    write_attribute(:status, STATUSES[val.intern])
  end

  def status
    STATUSES.key(read_attribute(:status))
  end

  [:current_sign_in_ip, :last_sign_in_ip].each do |field|
    define_method(field) do
      read_attribute(field).inet_itoa
    end

    define_method("#{field}=") do |value|
      write_attribute(field, value.inet_atoi)
    end

  end


end
