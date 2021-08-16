require 'csv_handler'

class IPerson
  def initialize
    @db = CsvHandler.new
    @messages = {
      :saved => "|Saved successfully!!",
      :already_saved => "|Contact already saved!",
      :not_found => "|Contact not found...",
      :no_contacts => "|No contacts to show...",
      :deleted => "|Deleted successfully!!",
      :updated => "|Updated successfully!"
    }
  end

  def save(person)
    find(person.name) ? @messages[:already_saved] : @db.append(person.to_array) && @messages[:saved]
  end

  def find(name)
    person = @db.find(name)
    person.empty? ? nil : person
  end

  def list_all
    contacts = @db.read[1..]
    contacts.empty? ? @messages[:no_contacts] : display(contacts)
  end

  def list_one(name)
    person = find(name) || []
    person.empty? ? @messages[:not_found] : display([person])
  end

  def delete(name)
    person = @db.delete(name)
    person.empty? ? @messages[:not_found] : @messages[:deleted]
  end

  def update(new_data)
    @db.update(new_data) && @messages[:updated]
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