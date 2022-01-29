extends RichTextLabel

var time := 30.00

func _process(delta):
	if(time > 0.0):
		time -= delta
		self.text = "TIME LEFT :" + String.num(time, 2)
	else:
		time 	
