# frozen_string_literal: true

require "test_helper"

class ContactsTest < Minitest::Test
  def setup
    @person = Person.new(
      name: 'Lucas',
      phone: '(99)99999-9999',
      email: 'lucas@example.com',
      birthday: '01/01/2000'
    )
  end

  def before_teardown
    File.delete(Person::CSV_NAME) if File.file?(Person::CSV_NAME)
  end

  def test_create_person    
    assert_equal 'Lucas', @person.name
    assert_equal '(99)99999-9999', @person.phone
    assert_equal 'lucas@example.com', @person.email
    assert_equal '01/01/2000', @person.birthday.strftime("%d/%m/%Y")
  end

  def test_create_person_nil_values_email_birthday
    p = Person.new(
      name: 'Lucas',
      phone: '(99)99999-9999',
      email: nil,
      birthday: nil
    )

    assert_equal 'Lucas', p.name
    assert_equal '(99)99999-9999', p.phone
    assert_nil p.email
    assert_nil p.birthday
  end

  def test_create_save_person_to_csv
    @person.save
    _, csv_info = CSV.read(Person::CSV_NAME)
    
    assert_equal ['Lucas', "(99)99999-9999", "lucas@example.com", "2000-01-01"], csv_info
  end

  def test_create_save_default_nil_person_to_csv
    p = Person.new(
      name: 'Lucas',
      phone: '(99)99999-9999',
      email: nil,
      birthday: nil
    )
    p.save
    _, csv_info = CSV.read(Person::CSV_NAME)

    assert_equal ['Lucas', "(99)99999-9999", nil, nil], csv_info
  end
  
  def test_show_empty_file_data
    File.delete(Person::CSV_NAME) if File.file?(Person::CSV_NAME)

    assert_nil Person.show
  end

  def test_show_empty_file_data_nonexistent_contact
    File.delete(Person::CSV_NAME) if File.file?(Person::CSV_NAME)

    assert_nil Person.show(name: 'Lucas')
  end

  def test_show_first_contact
    @person.save

    assert_equal true, Person.show
    assert_equal true, Person.show(name: 'Lucas')
  end

  def test_nonexistent_contact
    @person.save

    assert_nil Person.show(name: 'Carls')
  end
end
