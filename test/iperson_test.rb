# frozen_string_literal: true

require "test_helper"

class IPersonTest < Minitest::Test
  def setup
    @person = Person.new(
      name: 'Example',
      phone: '(99)99999-9999',
      email: 'example@example.com',
      birthday: '01/01/2000'
    )

    @Iperson = IPerson.new
  end

  def before_teardown
    File.delete(CsvHandler::CSV_NAME) if File.file?(CsvHandler::CSV_NAME)
  end

  def test_save_person_to_csv
    person = @Iperson.save(@person)
    
    assert_equal "|Saved successfully!!", person
  end

  def test_save_duplicated_person_to_csv
    @Iperson.save(@person)

    duplicated_person = @Iperson.save(@person)
    
    assert_equal "|Contact already saved!", duplicated_person
  end

  def test_list_nil
    person_controller = IPerson.new

    list_nil = person_controller.list_all

    assert_equal "|No contacts to show...", list_nil
  end

  def test_delete_person
    @Iperson.save(@person)
    deleted_person = @Iperson.delete(@person.name)

    assert_equal "|Deleted successfully!!", deleted_person
  end

  def test_update_person
    @Iperson.save(@person)

    new_data = ["Example", "(99)99999-9999", "updated@example.com", "01/01/2000"]

    @Iperson.update(new_data)

    updated_person = @Iperson.find(@person.name)

    assert_equal new_data, updated_person
  end
end
