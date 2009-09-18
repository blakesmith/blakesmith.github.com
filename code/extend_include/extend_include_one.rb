module SayHello
  def self.included(base)
    base.extend SayBye
  end

  module SayBye
    def bye
      puts 'bye'
    end
  end

  def hello
    puts 'hello'
  end
end

class Greeter
  include SayHello
end
