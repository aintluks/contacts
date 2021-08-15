require 'csv_handler'

class IPerson
  def initialize
    @db = CsvHandler.new
  end

  def save(person)
    !find(person.name).empty? ? "|Contact already saved!" : @db.append(person.to_array) && "|Saved successfully!!"
  end

  def find(name)
    if person = @db.find(name) then person end
  end

  def list_all
    contacts = @db.read
    if contacts.length == 1 then "|No contacts to show..." else display(contacts) end
  end

  def delete(name)
    if @db.delete(name).empty? then "|Contact not found..." else "|Deleted successfully!!" end
  end

  def update(new_data)
    @db.update(new_data) && "|Updated successfully!" 
  end

  private
    def display(contacts)
      puts "-----------------------"
      contacts.each do |contact|
        name, phone, email, birthday = contact
        display = "|Name: #{name}\n|Phone: #{phone}\n"
        display += "|Email: #{email}\n" if email
        display += "|Birthday: #{birthday}\n" if birthday
        puts display
        puts "-----------------------"
      end
    end
end