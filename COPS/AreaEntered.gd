extends Area2D

@export var areaNum : int 




func _on_area_2d_area_entered(area):
	if(area.get_parent().to == areaNum):
		area.get_parent().queue_free()
