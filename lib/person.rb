require 'date'
require 'csv'

class Person
  attr_accessor :name, :phone, :email, :birthday
  CSV_HEADER = "name,phone,email,birthday\n"
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

  def self.show(name: nil)
    csv =
    if File.file?(CSV_NAME)
      File.read(CSV_NAME) { |file| CSV.read(file) }.split("\n").map { |str| str.split(',') }
    else
      return puts "|No data to show..."
    end

    contacts = name ? csv.select { |data| data.first.upcase == name.upcase } : csv[1..csv.length]
    return puts "Contact not found!!" if contacts.empty?

    self.display(contacts) && true
  end

  def self.display(contacts)
    puts "-----------------------"
    contacts.each do |contact|
      name, phone, email, birthday = contact
      display = "|Name: #{name}\n|Phone: #{phone}\n"
      display += "|Email: #{email}\n" if email
      display += 
        if birthday
          birthday = Date.parse(birthday)
          "|Birthday: #{birthday.strftime("%d/%m/%Y")}\n"
        else
          ""
        end
      puts display
      puts "-----------------------"
    end
  end
end