# frozen_string_literal: true

require_relative "contacts/version"
require "person"
require "thor"

module Contacts
  class Error < StandardError; end
  class CLI < Thor
    desc "about", "Description only"
    def about
      puts "CLI contacts management tool"
    end
    
    desc "add", "Create a new person to your contact"
    options :name => :required, :phone => :required 
    options :email => :default, :birthday => :default
    def add
      person = Person.new(
        name: options[:name],
        phone: options[:phone],
        email: options[:email],
        birthday: options[:birthday]
      )

      puts person.save[:message]
    end

    desc "show", "Shows one specific or all contacts"
    options :name => :default
    def show
      res = options[:name] ? Person.show(name: options[:name]) : Person.show
      puts res[:message]
    end

    desc "del", "Delete a specific contact"
    options :name => :required
    def del
      res = Person.delete(name: options[:name])
      puts res[:message]
    end

    desc "edit", "Edit a specific contact"
    options :name => :required
    def edit
      arr_person = Person.find_one(name: options[:name])
      verify_edit = Person.verify_edit(arr_person)
      return puts verify_edit[:message] if verify_edit

      name, phone, email, birthday = arr_person.first
      
      puts "|Name: #{name}" # Can't change name (PK)
      phone = ask("|Phone:", :default => phone)
      email ? email = ask("|Email:", :default => email) : email = ask("|Email:", :default => nil)

      birthday = 
        if birthday
          year, month, day = birthday.split('-')
          ask("|Birthday:", :default => "#{day}/#{month}/#{year}")
        else
          ask("|Birthday:", :default => nil)
        end
      
      res = Person.edit(updated_data: [name, phone, email, birthday])
      
      puts res[:message]
    end
  end
end
