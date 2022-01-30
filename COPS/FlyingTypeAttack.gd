extends Node2D

var to : int
var positionToGoTo : Vector2

var kickIcon = load("res://icon.png")
var punchIcon = load("res://icon.png")
var insultIcon = load("res://icon.png")
var pokeIcon = load("res://icon.png")


@export var blue = Color("#4682b4")
@export var green = Color("#639765")
@export var red = Color("#a65455")

var dictOfWords := {
	"kick" : ["boot", "punt", "kick", "dropkick", "jolt", "calcitrate"],
	"punch" : ["drill", "jab", "stab", "bore", "pierce", "punch"],
	"insult" : ["annoy", "insult", "curse", "humiliate", "ridicule","taunt"],
	"poke" : ["dig", "nudge","shove", "jostle", "prod", "poke"],
}

var prompt = ""
var keyArray = [["kick", kickIcon], ["punch", punchIcon], ["insult",insultIcon], ["poke",pokeIcon]]


func init(_to : int, positionOfTo : Vector2):
	to = _to
	positionToGoTo = positionOfTo
	var cat = randi_range(0,3);
	get_child(0).texture = keyArray[cat][1]
	var words = dictOfWords[keyArray[cat][0]]
	var word = words[randi_range(0, words.size()-1)]
	prompt = word
	get_child(2).text = "[center]" +word


func _process(delta):
	self.position = self.position.move_toward(positionToGoTo, 300 * delta)


func set_next_character(next_character_index: int):
	var blue_text = get_bbcode_color_tag(blue) + prompt.substr(0, next_character_index) + get_bbcode_end_color_tag()
	var green_text = get_bbcode_color_tag(green) + prompt.substr(next_character_index, 1) + get_bbcode_end_color_tag()
	var red_text = ""
	if next_character_index != prompt.length():
		red_text = get_bbcode_color_tag(red) + prompt.substr(next_character_index + 1, prompt.length() - next_character_index + 1) + get_bbcode_end_color_tag()
	get_child(2).text = "[center]" + blue_text + green_text + red_text



func get_bbcode_color_tag(color: Color) -> String:
	return "[color=#" + color.to_html(false) + "]"


func get_bbcode_end_color_tag() -> String:
	return "[/color]"
