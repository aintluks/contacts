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
    person.empty? ? nil : person
  end

  def list_all
    contacts = @db.read[1..]
    contacts.empty? ? "|No contacts to show..." : display(contacts)
  end

  def list_one(name)
    person = find(name) || []
    person.empty? ? "|Contact not found..." : display([person])
  end

  def delete(name)
    person = @db.delete(name)
    person.empty? ? "|Contact not found..." : "|Deleted successfully!!"
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