# frozen_string_literal: true

class Card
  attr_reader :name, :value

  def initialize(name)
    @name = name.join
    get_value(name)
  end

  def get_value(name)
    if name[0] =~ /[J,Q,A,K]/
      @value = 10
      @value = 11 if name[0] == 'A'
    else
      @value = name[0].to_i
    end
  end
end
