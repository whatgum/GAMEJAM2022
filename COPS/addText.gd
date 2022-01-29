extends Control



func init(string :String) -> void:
	get_child(1).text = string;


func _on_button_pressed():
	get_parent().sendQuestion(get_child(1).text)
