require 'person_validate'

class Person
  attr_accessor :name, :phone, :email, :birthday

  def initialize(name:, phone:, email:, birthday:)
    @name = name
    @phone = phone
    @email = email
    @birthday = PersonValidate.date_birthday(birthday)
  end

  def to_array
    [@name, @phone, @email, @birthday]
  end
end