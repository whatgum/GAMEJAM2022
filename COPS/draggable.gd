extends RigidDynamicBody2D

var click_radius := 20
var dragging = false


# Called when the node enters the scene tree for the first time.
func _input(event : InputEvent):
	if(event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT):
		if (event.position - self.global_position).length() < click_radius:
			# Start dragging if the click is on the sprite.
			if not dragging && event.pressed:
				dragging = true
				self.freeze = true
		# Stop dragging if the button is released.
		if dragging and not event.pressed:
			self.collision_layer = 1
			self.collision_mask = 1
			dragging = false
			self.freeze = false
	if event is InputEventMouseMotion && dragging:
		# While dragging, move the sprite with the mouse.
		self.global_position = event.position
		self.linear_velocity = Vector2(0,0)

func _process(delta):
	get_parent().get_child(0).global_position = get_child(1).global_position
