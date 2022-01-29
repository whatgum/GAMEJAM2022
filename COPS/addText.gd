extends Control

var pressable : bool

func init(string :String, _pressable : bool) -> void:
	get_child(1).text = string
	self.pressable = _pressable

func _on_button_pressed():
	get_parent().sendQuestion(get_child(1).text, true, self.get_index())

func disableButtons(_set : bool):
	get_child(0).disabled = _set
