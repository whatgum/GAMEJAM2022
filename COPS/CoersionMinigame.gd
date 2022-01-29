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

var susBar : ProgressBar
var truthChanceLabel : RichTextLabel
@export var chanceRamp : Gradient 
# decimal between 0 and 100. Probability of success for Asking Nicely
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
	updateGUI(delta)
	pass

func sweetTalk():
	# increase sus
	var susRoll = randf_range(susIncreaseMin, susIncreaseMax)
	print(susRoll)
	suspicion += susRoll
	print(suspicion)
	# increase chances. scale chance increase with how high the sus changed
	var chanceModifier = (
		susRoll - susIncreaseMin)/(
			susIncreaseMax-susIncreaseMin)
			
	var chanceIncrease = chanceIncreaseMax*chanceModifier
	print(chanceIncrease)
	realChance += chanceIncrease
	print(realChance)
	# decrease sus decay speed
	# TODO resuming this in the morning

# little helper function where you pass in a number between 0 and 1.0, and it
# will return a color more red as it gets closer to 0, and more green as it
# gets closer to 1. Using this so it visually shows how decent your chances
# are
func getColorByPercent(percent):
	pass

func updateGUI(delta):
	susBar.value = suspicion
	truthChanceLabel.text = str(int(realChance)) + "%"
	truthChanceLabel.modulate = chanceRamp.interpolate(realChance/100)

