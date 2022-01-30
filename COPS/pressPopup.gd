extends Popup



func _on_dialog_manager_show_popup():
	popup_centered(Vector2i(400,200))


func _on_press_popup_popup_hide():
	get_tree().call_group("questions", "disableButtons", false)


func _on_pressed():
	self.visible = false
