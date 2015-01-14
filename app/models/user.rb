class User < ActiveRecord::Base
  has_secure_password

  def self.confirm(email_param, password_param)
    user = User.find_by({email: email_param})
    if user
      user.authenticate(password_param)
    end
  end
end
