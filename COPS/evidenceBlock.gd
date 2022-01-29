extends Node2D

var _texture = load("res://icon.png")
var _text = "I love oyu"
var _text2 = "plz lov me"


# Called when the node enters the scene tree for the first time.
func init(texture : Texture, string : String, string2 : String):
	get_child(0).get_child(0).init(texture, string, string2)
	get_child(0).get_child(0).get_child(2).disabled = true
	_texture = texture
	_text = string
	_text2 = string2
