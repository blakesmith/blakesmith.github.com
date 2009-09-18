module SayHello
  def hello
    puts 'hello'
  end
end

module SayBye
  def bye
    puts 'bye'
  end
end

class Greeter
  include SayHello
  extend SayBye
end
