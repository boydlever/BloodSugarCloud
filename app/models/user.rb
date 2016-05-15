class User < ActiveRecord::Base
  has_secure_password
  has_many :bg_measurements
  validates :phone_number, :email, :name, :presence => true
  
  (["password", "password_confirmation"] + column_names).each do |col|
    attr_accessible col.to_sym
  end
  
  before_create do |r|
    r.email = r.email.downcase
    if r.phone_number
      if r.phone_number[0] == "1"
        r.phone_number = r.phone_number[1..-1]
      end
      r.phone_number = r.phone_number.gsub(/\-|\(|\)| /, "")
    end
  end
end
