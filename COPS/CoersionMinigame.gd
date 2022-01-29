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

var susDecayBase : float = 2.5
var susDecayMult : float = 1 # Number goes down the more the player sweettalks

var susIncreaseMin : float = 20
var susIncreaseMax : float = 35

var running : bool = true
var timeElapsed : float = 0

var susBar : ProgressBar
var truthChanceLabel : RichTextLabel
var resultLabel : RichTextLabel
var exitButton : Button

@export var chanceRamp : Gradient 
# decimal between 0 and 100. Probability of success for Asking Nicely
var realChance : float = 0
var chanceIncreaseMax : float = 25

# Do the classic X-COM "Show the player a lower chance than it actually is
# so they don't feel like the game is bullshit" tactic. Plus helps with
# showing the chance as integer.
var displayedChance : float = 0
var dispayedChanceChangeSpeed : int = 50
var currentChanceColor : Color



var resultFadeInDuration : float = 0.8 # time it takes for result to fade in
var isDisplayingResult := false
var timeDisplayingResult : float = 0

func _ready():
	truthChanceLabel = get_node("SuspicionZone/TruthChance")
	susBar = get_node("SuspicionZone/ProgressBar")
	resultLabel = get_node("ResultZone/ResultLabel")
	exitButton = get_node("ResultZone/ExitButton")

func startGame():
	suspicion = 0
	realChance = 0
	susDecayBase = 2.5
	susDecayMult = 1.0
	displayedChance = 0

func _process(delta):
	updateGUI(delta)
	decaySuspicion(delta)
	

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
	if(susDecayMult > 0):
		susDecayMult -= 0.1
	
	
	
	

func askNicely():
	var roll = randf_range(0, 100)
	if roll <= realChance:
		# SUCCESS
		print("SUCCESS ROLL=", roll)
		endMinigame(true)
	else:
		# FAILURE
		print("FAILURE ROLL=", roll)
		endMinigame(false)
	
	

func decaySuspicion(delta):
	if running:
		suspicion -= susDecayBase*susDecayMult*delta
		if suspicion < 0:
			suspicion = 0
		elif suspicion > 100:
			endMinigame(false)



func updateGUI(delta):
	susBar.value = suspicion
	if displayedChance < int(realChance):
		displayedChance += delta*dispayedChanceChangeSpeed
	elif displayedChance > int(realChance):
		displayedChance = realChance
	
	
	# result fadein code
	if isDisplayingResult:
		timeDisplayingResult+=delta
		resultLabel.modulate += Color(0,0,0,lerp(0,1,timeDisplayingResult/resultFadeInDuration))
		exitButton.modulate += Color(0,0,0,lerp(0,1,timeDisplayingResult/resultFadeInDuration))
	else:
		resultLabel.modulate = Color(0,0,0,0)
		exitButton.modulate = Color(1,1,1,0) # we don't have to worry about diff. colors for this guy
	
	truthChanceLabel.text = str(int(displayedChance)) + "%"
	truthChanceLabel.modulate = chanceRamp.interpolate(realChance/100)


func showResult(won):
	isDisplayingResult = true
	exitButton.visible = true
	if won:
		resultLabel.text = "[center][b]GOT 'EM![/b][/center]"
		resultLabel.modulate = Color.GREEN * Color(1, 1, 1, 0)
		
	else:
		resultLabel.text = "[center][b]THEY CAUGHT ON![/b][/center]"
		resultLabel.modulate = Color.RED * Color(1, 1, 1, 0)
		

func endMinigame(isSuccessful):
	running = false
	showResult(isSuccessful)
	pass

func closeMinigame():
	visible = false

func _on_sweet_talk_button_pressed():
	sweetTalk()
	pass # Replace with function body.


func _on_ask_nicely_button_pressed():
	askNicely()
	pass # Replace with function body.
