extends Sprite2D

var wideMouth = load("res://intervieweeMouthWide.png")
var tallMouth = load("res://intervieweeMouthTall.png")
var closedMouth = load("res://intervieweeMouthClosed.png")


var index = 0


func _on_questioning_start_talking():
	self.texture = wideMouth
	index = 0
	get_parent().get_child(4).start()


func _on_questioning_stop_talking():
	self.texture = closedMouth
	get_parent().get_child(4).stop()

func _on_mouth_timer_timeout():
	index += 1
	if(index > 2):
		index = 0
	match(index):
		0:
			self.texture = wideMouth
		1:
			self.texture = tallMouth
		2:
			self.texture = closedMouth
	get_parent().get_child(4).start()
