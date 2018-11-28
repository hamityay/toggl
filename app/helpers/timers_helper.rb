module TimersHelper
  def get_users
    User.all.pluck :username, :id
  end

  def get_types
    Type.all.pluck :name, :id
  end
end
