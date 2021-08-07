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
      
      person.save
    end

    desc "show", "Shows one specific or all contacts"
    options :name => :default
    def show
      options[:name] ? Person.show(name: options[:name]) : Person.show
    end
  end
end
