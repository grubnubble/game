#!/usr/bin/ruby

require_relative 'card'
require_relative 'player'

#method to check for a winner; returns the winner if it exists
def winner(array)
	#first sort our players by score, highest to lowest
	array.sort! {|a,b| b <=> a}
	highest = array[0]
	second = array[1]

	if highest.score >= 21
		#make sure the winner wins by at least 2 points
		unless (highest - second).abs < 2
			return highest
		end
	end
end

#to populate the deck, we'll need some arrays
deck = []
numbers = [2,3,4,5,6,7,8,9,10,"J","Q","K","A"]
suits = ["Clubs","Diamonds","Hearts","Spades"]

#let's get the standard deck first
numbers.each do |n|
	suits.each do |s|
		deck << Card.new(n,s,)
	end
end

#and set a value for each card, to make comparisons between cards easier
v = 0
deck.each do |c|
	c.value = v
	v += 1
	puts "#{c}, #{c.value}"
end

#now we'll add 4 penalty cards to the deck
for i in 1..4
	deck << Card.new("P", "", -1)
end

#and begin the game
puts "Let's play a game! Enter the number of players (2-4)."
num_players = gets.chomp.to_i

#make sure the number of players is valid
while (num_players < 2) || (num_players > 4)
	puts "Please enter a valid number of players (2 to 4)"
	num_players = gets.chomp.to_i
end

#initialize the number of players we need into a players array
players = []
for i in 1..num_players do
	players << Player.new(i, 0, )
end

puts "Ok, we have #{num_players} players."

#to hold the cards drawn during each round
round = []
round_counter = 0

while not win = winner(players)
	round_counter += 1
	puts "Begin Round #{round_counter}"

	#shuffle the deck
	puts "Let's shuffle the deck (press Enter)."
	gets.chomp
	deck.shuffle!

	#sort the players so that player 1 is always first to draw
	players.sort_by! &:name

	#draw a card, assign card, assign card's owner
	players.each do |p|
		puts "Player #{p}, draw a card (press Enter)"
		gets.chomp

		#assign card to player and player to card
		card = deck.pop
		p.card = card
		card.owner = p

		#collect the card
		round << card

		#if a penalty card is drawn, 1 point is deducted and play moves to next player
		if card.number == 'P'
			puts "Oh no! You got a penalty card! 1 point will be deducted from your score."
			puts ""
			puts ""
			p.score += -1
		else 
			puts "Your card is the #{card}"
			puts ""
			puts ""
		end
	end

	#sort the round's card from highest to lowest value, add 2 points to winner's score
	round.sort! {|a,b| b <=> a}
	r_winner = round[0].owner
	r_winner.score += 2 

	#display the winner of the round (and all players' scores)
	players.each do |p|
		puts "Player #{p} score: #{p.score}"
	end
	puts "The winner of this round is Player #{r_winner}"
	puts "-------------------------------------"
	puts ""

	#take cards out of our temporary array, put them back into the deck in preparation for the next round
	for i in 1..round.length do
		deck << round.pop
	end
end

puts "We have a winner! The winner for this game is Player #{win}"
