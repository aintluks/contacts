require 'date'

class Person
  attr_accessor :name, :phone, :email, :birthday

  def initialize(name:, phone:, email:, birthday:)
    @name = name
    @phone = phone
    @email = email
    @birthday = Date.parse(birthday)
  end
end