extends Node2D

var to : int
var positionToGoTo : Vector2
func init(_to : int, positionOfTo : Vector2):
	to = _to
	positionToGoTo = positionOfTo

func _process(delta):
	self.position.x = lerp(self.position.x, positionToGoTo.x, delta)
	self.position.y = lerp(self.position.y, positionToGoTo.y, delta)
