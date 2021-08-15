require 'csv_handler'

class IPerson
  def initialize
    @db = CsvHandler.new
  end

  def save(person)
    find(person.name) ? "|Contact already saved!" : @db.append(person.to_array) && "|Saved successfully!!"
  end

  def find(name)
    person = @db.find(name)
    if person.empty? then nil else person end
  end

  def list_all
    contacts = @db.read[1..]
    if contacts.empty? then "|No contacts to show..." else display(contacts) end
  end

  def list_one(name)
    person = find(name) || []
    if person.empty? then "|Contact not found..." else display([person]) end
  end

  def delete(name)
    if @db.delete(name).empty? then "|Contact not found..." else "|Deleted successfully!!" end
  end

  def update(new_data)
    @db.update(new_data) && "|Updated successfully!" 
  end

  private
    def display(contacts)
      display = "-----------------------\n"
      contacts.each do |contact|
        name, phone, email, birthday = contact
        display += "|Name: #{name}\n|Phone: #{phone}\n"
        display += "|Email: #{email}\n" if email
        display += "|Birthday: #{birthday}\n" if birthday
        display += "-----------------------\n"
      end
      display
    end
end