class Person
  attr_accessor :name, :phone, :email, :birthday

  def initialize(name:, phone:, email:, birthday:)
    @name = name
    @phone = phone
    @email = email
    @birthday = birthday
  end

  def to_array
    [@name, @phone, @email, @birthday]
  end
end