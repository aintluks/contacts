# frozen_string_literal: true

require_relative "contacts/version"
require "person"
require "iperson"
require "thor"

module Contacts
  class Error < StandardError; end
  class CLI < Thor
    @@IPerson = IPerson.new

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

      puts @@IPerson.save(person)
    end

    desc "list", "List one or all contacts, use --name for specific one"
    options :name => :default
    def list
      options[:name] ? (puts @@IPerson.list_one(options[:name])) : (puts @@IPerson.list_all)
    end

    desc "del", "Delete a specific contact"
    options :name => :required
    def del
      puts @@IPerson.delete(options[:name])
    end

    desc "update", "Update a specific contact"
    options :name => :required
    def update
      person = @@IPerson.find(options[:name])
      if !person then return puts "|Contact not found..." end

      name, phone, email, birthday = person
      
      puts "|Name: #{name}" # Can't change name (PK)
      phone = ask("|Phone:", :default => phone)
      email ? email = ask("|Email:", :default => email) : email = ask("|Email:", :default => nil)
      birthday ? birthday = ask("|Birthday:", :default => birthday) : birthday = ask("|Birthday:", :default => nil)
      
      puts @@IPerson.update([name, phone, email, birthday])
    end
  end
end
