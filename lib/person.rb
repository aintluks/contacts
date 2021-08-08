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
    birthday.nil? || birthday.empty? ? @birthday = nil : @birthday = Date.parse(birthday)

    File.open(CSV_NAME, "a") { |file| file.write(CSV_HEADER) } unless File.file?(CSV_NAME)
  end

  def save
    input_string = [@name, @phone, @email, @birthday]
    verify_exists = Person.find_one(name: @name)
    return { message: "|Contact already saved!" } unless verify_exists.empty?

    File.open(CSV_NAME, "a") { |file| file.write(input_string.join(',') + "\n") }

    { message: "|Saved successfully!!" }
  end

  def self.show(name: nil)
    csv = self.csv_exists?
    return { message: "|No contacts to show..." } unless csv

    contacts = name ? self.find_one(name: name) : csv[1..csv.length]
    return { message: "|Contact not found..." } if contacts.empty?

    self.display(contacts)

    { message: "" }
  end

  def self.delete(name:)
    csv = self.csv_exists?
    return { message: "|No contact to delete..." } unless csv

    to_remove = csv.map.with_index { |data, index| index if data.first.upcase == name.upcase }
      .select { |index| index }
    
    return { message: "|Contact not found..." } if to_remove.empty?
    
    res = csv.delete_at(to_remove.first)

    File.open(CSV_NAME, "w") do |file|
      csv.map { |row| file.write(row.join(',') + "\n") }
    end

    { message: "|Deleted successfully!!" }
  end

  def self.find_one(name:)
    csv = self.csv_exists?
    return { message: "|No contact to find..." } unless csv

    res = csv.select { |data| data.first.upcase == name.upcase }
    res.empty? ? [] : res
  end

  def self.verify_edit(arr)
    res =
      if arr.class == Hash
        { message: arr[:message] }
      elsif arr.empty?
        { message: "|Contact not found..." }
      end
  end

  def self.edit(updated_data:)
    updated_data[-1] = Date.parse(updated_data[-1])
    csv = self.read_file.map { |arr| arr.first != updated_data.first ? arr : updated_data }

    File.open(CSV_NAME, "w") do |file|
      csv.map { |row| file.write(row.join(',') + "\n") }
    end

    { message: "|Updated successfully!" }
  end

  private
    def self.read_file
      File.read(CSV_NAME) { |file| CSV.read(file) }.split("\n").map { |str| str.split(',') }
    end

    def self.csv_exists?
      File.file?(CSV_NAME) ? self.read_file : return
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