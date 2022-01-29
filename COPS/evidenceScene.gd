extends Panel

# Purpose : sets up the scene
func init(texture : Texture, string : String, string2 : String) -> void:
	get_child(0).texture = texture
	get_child(1).text = string
	get_child(3).get_child(0).text = string2


func _on_texture_button_pressed():
	Input.set_custom_mouse_cursor(get_child(0).texture)
	get_parent().get_parent().get_parent().visible = false


