# frozen_string_literal: true

class Card
  attr_reader :name, :value, :suit

  def initialize(value)
    @name = value[0] + value[1]
    @suit = value[1]
    get_value(value[0])
  end

  def get_value(value)
    if value =~ /[J,Q,A,K]/
      @value = 10
      @value = 11 if value == 'A'
    else
      @value = value.to_i
    end
  end
end
