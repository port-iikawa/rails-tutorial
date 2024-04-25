class User
    attr_accessor :name, :email, :first_name, :last_name

    def initialize(first_name = '', last_name = '', email = '')
        @first_name = first_name
        @last_name = last_name
        @email = email
    end

    def formatted_email
        "#{@name} <#{@email}>"
    end
end