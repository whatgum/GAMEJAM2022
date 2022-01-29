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

func _on_timer_timeout():
	var rand = RandomNumberGenerator.new()
	var from = randi_range(0,7)
	while(from == justUsed):
		from = randi_range(0,7)
	justUsed = from
	var arrayOfLocation = dictOfSpace[from]
	var to = randi_range(0, arrayOfLocation.size()-1)
	to = arrayOfLocation[to]
	print("going from :" + String(get_child(from).name) + " to : " + String(get_child(to).name) as String)
	var newFlyer = flyingTypeAttack.instantiate()
	newFlyer.init(to, get_child(to).position)
	self.add_child(newFlyer)
	newFlyer.position = get_child(from).position
