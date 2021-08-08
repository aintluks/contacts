# frozen_string_literal: true

require "test_helper"

class ContactsTest < Minitest::Test
  def setup
    File.delete(Person::CSV_NAME) if File.file?(Person::CSV_NAME)

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

  def test_create_save_person_to_csv
    @person.save
    @person.save
    
    csv_info = CSV.read(Person::CSV_NAME)

    assert_equal 2, csv_info.length
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
    File.delete(Person::CSV_NAME)

    res = Person.show

    assert_equal "|No contacts to show...", res[:message]
  end

  def test_show_empty_file_data_nonexistent_contact
    File.delete(Person::CSV_NAME)

    res = Person.show(name: 'Lucas')

    assert_equal "|No contacts to show...", res[:message]
  end

  def test_show_first_contact
    @person.save

    res_one = Person.show
    res_two = Person.show(name: 'Lucas')

    assert_equal "", res_one[:message]
    assert_equal "", res_two[:message]
  end

  def test_nonexistent_contact
    @person.save
    
    res = Person.show(name: 'Carls')
    
    assert_equal "|Contact not found...", res[:message]
  end

  def test_delete_person_empty_file
    File.delete(Person::CSV_NAME)
    
    res = Person.delete(name: 'Lucas')

    assert_equal "|No contact to delete...", res[:message]
  end

  def test_delete_nonexistent_person
    @person.save

    res = Person.delete(name: 'Carls')

    assert_equal "|Contact not found...", res[:message]
  end

  def test_delete_person
    @person.save

    res = Person.delete(name: 'Lucas')

    assert_equal "|Deleted successfully!!", res[:message] 
  end

  def test_find_one
    @person.save

    res = Person.find_one(name: 'Lucas').first

    assert_equal ['Lucas', "(99)99999-9999", "lucas@example.com", "2000-01-01"], res
  end

  def test_find_one_nonexistent_file
    File.delete(Person::CSV_NAME)

    res = Person.find_one(name: 'Carls')

    assert_equal "|No contact to find...", res[:message]
  end

  def test_find_one_nonexistent_person
    @person.save

    res = Person.find_one(name: 'Carls')

    assert_equal [], res
  end

  def test_edit_one
    @person.save

    name = "Lucas"
    email = "lucas@edit.com"
    phone = "9999-9999"
    birthday = "19/02/1992"
    
    edited_person = Person.edit(updated_data: [name, phone, email, birthday])
    compare_person = Person.find_one(name: 'Lucas')

    assert_equal "|Updated successfully!", edited_person[:message]
    assert_equal ["Lucas", "9999-9999", "lucas@edit.com", "1992-02-19"], compare_person.first
  end
end
