# frozen_string_literal: true

require_relative "contacts/version"
require "thor"

module Contacts
  class Error < StandardError; end
  class CLI < Thor
    desc "about", "description only"
    def about
      puts "CLI contacts management tool"
    end
  end
end
