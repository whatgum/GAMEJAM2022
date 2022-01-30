extends StaticBody2D


var evidencesOnMe = []

signal move(direction)
signal removeFromOtherScale(body)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if(!evidencesOnMe.has(body)):
		evidencesOnMe.append(body)
		self.position.y += 10
		emit_signal("move", -10)
		emit_signal('removeFromOtherScale', body)
		get_child(2).position.y -= 50

func _on_guilty_move(direction):
	self.position.y += direction


func _on_inocent_move(direction):
	self.position.y += direction


func _on_guilty_remove_from_other_scale(body):
	if(evidencesOnMe.has(body)):
		self.evidencesOnMe.erase(body)
		self.position.y += -10
		emit_signal("move", 10)
		get_child(2).position.y += 50

func _on_inocent_remove_from_other_scale(body):
	if(evidencesOnMe.has(body)):
		self.evidencesOnMe.erase(body)
		self.position.y += -10
		emit_signal("move", 10)
		get_child(2).position.y += 50
