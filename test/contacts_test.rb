# frozen_string_literal: true

require "test_helper"

class ContactsTest < Minitest::Test
  def test_create_person
    p = Person.new(name: 'Lucas',
                  phone: '(99)99999-9999',
                  email: 'lucas@example.com',
                  birthday: '01/01/2000')
    
    assert_equal 'Lucas', p.name
    assert_equal '(99)99999-9999', p.phone
    assert_equal 'lucas@example.com', p.email
    assert_equal '01/01/2000', p.birthday.strftime("%d/%m/%Y")
  end
end
