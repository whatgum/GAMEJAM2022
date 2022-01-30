extends Node2D

var justUsed := 0

var dictOfSpace = {
	0 : [3,4,5, 6,7],
	1 : [3,4,5],
	2 : [5,6,7],
	3 : [0,1,5,6,7],
	4 : [0,1,7],
	5 : [0,1,2,3,7],
	6 : [0, 2, 3,],
	7 : [0,2,3,4,5]
}

var flyingTypeAttack = load("res://FlyingTypeAttack.tscn")

var activeEnemy = null
var currLetterIndex = 0
signal reduceResistance(prompt)
signal shake
var gameOver = false

func _on_timer_timeout():
	var rand = RandomNumberGenerator.new()
	var from = randi_range(0,7)
	while(from == justUsed):
		from = randi_range(0,7)
	justUsed = from
	var arrayOfLocation = dictOfSpace[from]
	var to = randi_range(0, arrayOfLocation.size()-1)
	to = arrayOfLocation[to]
	var newFlyer = flyingTypeAttack.instantiate()
	newFlyer.init(to, get_child(to).position)
	self.add_child(newFlyer)
	newFlyer.position = get_child(from).position


func find_new_active_enemy(key):
	for enemy in self.get_children():
		if(enemy.get_index() > 7): 
			var prompt = enemy.prompt
			var next_character = prompt.substr(0, 1)
			if next_character == key:
				activeEnemy = enemy
				currLetterIndex = 1
				activeEnemy.set_next_character(currLetterIndex)
				return


func processCurrentEnemy(key):
	var prompt = activeEnemy.prompt
	var next_character = prompt.substr(currLetterIndex, 1)
	if key == next_character:
		currLetterIndex += 1
		activeEnemy.set_next_character(currLetterIndex)
	if currLetterIndex == prompt.length():
		currLetterIndex = -1
		activeEnemy.queue_free()
		activeEnemy = null
		emit_signal("reduceResistance", prompt)
		emit_signal("shake")



func _unhandled_key_input(event):
	if(gameOver):
		return
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var typed_event = event as InputEventKey
		var key = OS.get_keycode_string(event.keycode)
		key = key.to_lower()
		if activeEnemy == null:
			find_new_active_enemy(key)
		else:
			processCurrentEnemy(key)
			
