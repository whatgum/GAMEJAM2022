extends Line2D


var point = Vector2(259, 101)
# Called when the node enters the scene tree for the first time.
func _process(delta):
	set_point_position(0, get_parent().get_child(6).global_position)
	set_point_position(2, get_parent().get_child(7).global_position)
