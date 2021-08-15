# frozen_string_literal: true

require "test_helper"

class PersonTest < Minitest::Test
  def before_teardown
    File.delete(CsvHandler::CSV_NAME) if File.file?(CsvHandler::CSV_NAME)
  end
  
  def test_create_person
    person = Person.new(
      name: 'Example',
      phone: '(99)99999-9999',
      email: 'example@example.com',
      birthday: '01/01/2000'
    )

    assert_equal 'Example', person.name
    assert_equal '(99)99999-9999', person.phone
    assert_equal 'example@example.com', person.email
    assert_equal '01/01/2000', person.birthday
  end

  def test_create_person_nil_values_email_birthday
    person = Person.new(
      name: 'Example',
      phone: '(99)99999-9999',
      email: nil,
      birthday: nil
    )

    assert_equal 'Example', person.name
    assert_equal '(99)99999-9999', person.phone
    assert_nil person.email
    assert_nil person.birthday
  end
end
