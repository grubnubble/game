class Card
	attr_accessor :number, :suit, :value, :owner
	 
  def initialize(number='', suit='', value=0)
    @number = number
    @suit = suit
    @value = value
  end

  def <=>(card)
  	return self.value <=> card.value
  end

  def to_s
  	"#{self.number} of #{self.suit}"
  end

end