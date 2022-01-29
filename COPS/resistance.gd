extends ProgressBar

var healsBy = 1.0
var reducePerLetter = 2
var reducePerWord = 1

signal gameOver(won)

var game_over = false
func _process(delta):
	if(self.value  <= 0.0 && game_over == false):
		emit_signal("gameOver", true)
		game_over = true
	if(self.value < self.max_value && game_over == false):
		self.value += healsBy * delta



func _on_places_to_go_reduce_resistance(prompt):
	self.value -= (prompt.length() * reducePerLetter) * reducePerWord
