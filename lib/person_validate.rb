class PersonValidate
  def self.date_birthday(birthday)
    birthday.nil? || birthday.empty? ? nil : Date.parse(birthday)
  end
end