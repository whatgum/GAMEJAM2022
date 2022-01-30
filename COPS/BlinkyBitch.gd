extends Sprite2D


var closed = load("res://intervieweeEyesClosed.png")
var open = load("res://intervieweeEyesOpen.png")
var eyesClosed = false
var parentPosition 

var shaking = false

func _on_timer_timeout():
	print('blink')
	var nextBlink = randf_range(0.0, 5.0);
	self.texture = closed
	get_parent().get_child(2).start(nextBlink)
	get_parent().get_child(3).start()

func _on_blick_open_timer_timeout():
	self.texture = open


func _on_abuse_comes_cheap_shake():
	parentPosition = get_parent().position
	shaking = true
	get_parent().get_child(5).start()

func _process(delta):
	if(shaking):
		var amtX = randf_range(1.0, 3.0)
		var amtY = randf_range(1.0, 3.0)
		var direction = randi_range(0,1)
		if(direction == 1):
			get_parent().position += Vector2(amtX, amtY)
		if(direction == 0):
			get_parent().position -= Vector2(amtX, amtY)


func _on_shake_timer_timeout():
	shaking = false
	get_parent().position = parentPosition
