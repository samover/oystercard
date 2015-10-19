require './lib/oystercard'

card = Oystercard.new

card.top_up(60)

p card

begin
card.top_up(60)
rescue Exception => deon_the_lad
p card
puts "Capacity feature not found #{deon_the_lad.inspect}"
end

card.deduct(60)
p card
