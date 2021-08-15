# frozen_string_literal: true

require "test_helper"

class CsvHandlerTest < Minitest::Test
  def setup
    @person = Person.new(
      name: 'Example',
      phone: '(99)99999-9999',
      email: 'example@example.com',
      birthday: '01/01/2000'
    )

    @csv = CsvHandler.new
  end

  def before_teardown
    File.delete(CsvHandler::CSV_NAME) if File.file?(CsvHandler::CSV_NAME)
  end

  def test_read_header
    data = @csv.read.first

    assert_equal ["name", "phone", "email", "birthday"], data
  end

  def test_append_person
    @csv.append(@person.to_array)

    csv_info = @csv.read[1..].first
    
    assert_equal ['Example', "(99)99999-9999", "example@example.com", "01/01/2000"], csv_info
  end

  def test_append_person_nil_values
    new_person = Person.new(
      name: 'Example',
      phone: '(99)99999-9999',
      email: nil,
      birthday: nil
    )

    @csv.append(new_person.to_array)

    csv_info = @csv.read[1..].first
    
    assert_equal ['Example', "(99)99999-9999"], csv_info
  end

  def test_append_two_person
    new_person = Person.new(
      name: 'Example Two',
      phone: '(99)99999-9999',
      email: nil,
      birthday: nil
    )

    @csv.append(@person.to_array)
    @csv.append(new_person.to_array)

    csv_info_one, csv_info_two = @csv.read[1..]
    

    assert_equal ['Example', "(99)99999-9999", "example@example.com", "01/01/2000"], csv_info_one
    assert_equal ['Example Two', "(99)99999-9999"], csv_info_two
  end

  def test_find_one_person
    @csv.append(@person.to_array)
    
    person_result = @csv.find(@person.name)

    assert_equal ['Example', "(99)99999-9999", "example@example.com", "01/01/2000"], person_result
  end

  def test_find_one_nonexistent_person
    @csv.append(@person.to_array)
    
    person_result = @csv.find('Example Mock')

    assert_equal [], person_result
  end

  def test_find_one_of_two
    new_person = Person.new(
      name: 'Example Two',
      phone: '(99)99999-9999',
      email: nil,
      birthday: nil
    )

    @csv.append(new_person.to_array)
    @csv.append(@person.to_array)

    person_result = @csv.find(@person.name)

    assert_equal ['Example', "(99)99999-9999", "example@example.com", "01/01/2000"], person_result
  end

  def test_delete_one
    @csv.append(@person.to_array)
    @csv.delete('Example')

    person_deleted = @csv.find(@person.name)

    assert_equal [], person_deleted
  end

  def test_delete_one_nonexistent
    @csv.append(@person.to_array)
    @csv.delete('Example two')

    person_result = @csv.find(@person.name)

    assert_equal ['Example', "(99)99999-9999", "example@example.com", "01/01/2000"], person_result
  end

  def test_update_person
    @csv.append(@person.to_array)
    
    new_data = ["Example", "(99)99999-9999", "updated@example.com", "01/01/2000"]

    @csv.update(new_data)

    updated_person = @csv.find(@person.name)

    assert_equal new_data, updated_person
  end
end
