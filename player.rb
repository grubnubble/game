class Player
	attr_accessor :name, :score, :card
	 
  def initialize(name='', score=0)
    @name = name
    @score = score
    @card = Card.new()
  end

  def <=>(player)
  	return self.score <=> player.score
  end

  def -(player)
  	return self.score - player.score
  end

  def to_s
  	self.name.to_s
  end

end