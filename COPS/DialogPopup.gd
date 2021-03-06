extends RichTextLabel

var runningTime = 0

signal finishedDialgue(text)
# Each character adds this many seconds before fading
var fadeDelayPerCharacter = .035 

# How quickly the dialog fades
var fadeSpeedMultiplier = 1.0


func _ready():
	scroll_active = false
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	runningTime += delta
	if(runningTime >= (fadeDelayPerCharacter*text.length())):
		modulate.a -= (delta*fadeSpeedMultiplier) # Base: 1 second to fade
	
	if modulate.a <= 0:
		queue_free()
		emit_signal("finishedDialgue", text.substr(23))
