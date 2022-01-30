extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_questioning_start_abuse():
	get_child(4).init()


func _on_questioning_startcohersion():
	get_child(1).visible = true
	get_child(1).init()
