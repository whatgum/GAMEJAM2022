extends PopupPanel




func _on_evidence_button_pressed():
	popup_centered(Vector2i(500,500))

func sendEvidence(string : String) -> void:
	if(string.begins_with("[center]")):
		string = string.substr(8)
	get_parent().currentEvidence = string
