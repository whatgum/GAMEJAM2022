extends ProgressBar

var healsBy = 1.0
func _process(delta):
	if(self.value  <= 0.0):
		print("gameover man, game over!")
	if(self.value < self.max_value):
		self.value += healsBy * delta
	
