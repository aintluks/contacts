require 'date'
require 'csv'

class Person
  attr_accessor :name, :phone, :email, :birthday
  CSV_HEADER = "name, phone, email, birthday\n"
  CSV_NAME = "data/contacts.csv"

  def initialize(name:, phone:, email:, birthday:)
    @name = name
    @phone = phone
    @email = email
    @birthday = Date.parse(birthday) if birthday
    File.open(CSV_NAME, "a") { |file| file.write(CSV_HEADER) } unless File.file?(CSV_NAME)
  end

  def save
    input_string = [@name, @phone, @email, @birthday]
    
    File.open(CSV_NAME, "a") { |file| file.write(input_string.join(',') + "\n") }

    puts "Saved successfully!!"
  end
end