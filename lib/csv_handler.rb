require 'csv'

class CsvHandler
  CSV_HEADER = "name,phone,email,birthday\n"
  CSV_NAME = "data/contacts.csv"

  def initialize
    File.open(CSV_NAME, "a") { |file| file.write(CSV_HEADER) } unless File.file?(CSV_NAME)
  end

  def read
    File.read(CSV_NAME) { |file| CSV.read(file) }.split("\n").map { |str| str.split(',') }
  end

  def delete(name)
    csv = read
    to_remove = csv.map.with_index { |data, index| index if data.first.upcase == name.upcase }
      .select { |index| index }

    if to_remove.empty? then return [] end
    
    csv.delete_at(to_remove.first)

    File.open(CSV_NAME, "w") { |file| csv.map { |row| file.write(row.join(',') + "\n") } } && to_remove
  end

  def update(new_data)
    csv = read.map { |arr| arr.first != new_data.first ? arr : new_data }

    File.open(CSV_NAME, "w") { |file| csv.map { |row| file.write(row.join(',') + "\n") } }
  end

  def empty?
    File.file?(CSV_NAME) ? read : nil
  end

  def append(input_string)
    File.open(CSV_NAME, "a") { |file| file.write(input_string.join(',') + "\n") }
  end

  def find(name)
    if find = read.select { |data| data.first.upcase == name.upcase }.first then find else [] end
  end
end