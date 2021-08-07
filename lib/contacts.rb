# frozen_string_literal: true

require_relative "contacts/version"
require "person"
require "thor"

module Contacts
  class Error < StandardError; end
  class CLI < Thor
    desc "about", "description only"
    def about
      puts "CLI contacts management tool"
    end
    
    desc "add", "create a new person to your contact"
    options :name => :required, :phone => :required 
    options :email => :default, :birthday => :default
    def add
      person = Person.new(
        name: options[:name],
        phone: options[:phone],
        email: options[:email],
        birthday: options[:birthday]
      )
      
      person.save
    end
  end
end
