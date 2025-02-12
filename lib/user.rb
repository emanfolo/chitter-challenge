require_relative 'database_connection'

class User
  def self.create(email:, password:, username:)
    result = DatabaseConnection.query(
      "INSERT INTO users (email, password, username) VALUES($1, $2, $3) RETURNING id, email, username;",
      [email, password, username]
    )
    User.new(id: result[0]['id'], email: result[0]['email'], username: result[0]['username'])
  end

  def self.find(id)
    return nil unless id
    result = DatabaseConnection.query(
      "SELECT * FROM users WHERE id = $1",
      [id]
    )
    User.new(id: result[0]['id'], email: result[0]['email'], username: result[0]['username'])
  end
  
  attr_reader :id, :email, :username

  def initialize(id:, email:, username:)
    @id = id
    @email = email
    @username = username
  end 
end
