extends Node2D

# Each "turn" you can either:

#	SWEET TALK : Give the suspect something nice, INCREASE odds of getting truth
#				 but RAISES the suspect's suspicion meter. If the suspicion
#				 meter maxes out, you get nothing. Suspicion drops over time,
#				 but drops slower and slower the more you sweet talk, which
#				 encourages risking it.

#	ASK NICELY : Ask the suspect about the crime. Whether or not they give up
#				evidence is based on how much you've sweet talked them

#	THE OBJECT : To sweet talk the suspect as much as possible to increase
#				your chances, and then RISK IT for the evidence. Since
#				the Sus O' Meter drops slower and slower, it will cost you
#				time to maximize your chances. Game ends when you ask nicely. 



var suspicion : float = 0 # Between 0 and 100, 100 being losing
var susDecayMult : float = 1 # Number goes down the more the player sweettalks
var susIncreaseMin : float = 10
var susIncreaseMax : float = 25

var susBar
var truthChanceLabel
# decimal between 0.0 and 1.0. Probability of success for Asking Nicely
var realChance : float = 0
var chanceIncreaseMax : float = 25

# Do the classic X-COM "Show the player a lower chance than it actually is
# so they don't feel like the game is bullshit" tactic. Plus helps with
# showing the chance as integer.
var displayedChance : int = 0
var currentChanceColor : Color

var timeTransitioning = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	truthChanceLabel = get_node("SuspicionZone/TruthChance")
	susBar = get_node("SuspicionZone/ProgressBar")
	sweetTalk()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func sweetTalk():
	# increase sus
	var susRoll = randf_range(susIncreaseMin, susIncreaseMax)
	suspicion += susRoll
	
	# increase chances. scale chance increase with how high the sus changed
	var chanceModifier = (
		susRoll - susIncreaseMin)/(
			susIncreaseMax-susIncreaseMin)
			
	var chanceIncrease = chanceIncreaseMax*chanceModifier
	realChance += chanceIncrease

	# decrease sus decay speed
	# TODO resuming this in the morning

	
