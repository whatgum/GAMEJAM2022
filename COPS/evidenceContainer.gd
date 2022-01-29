extends VBoxContainer

var evidence = load("res://evidenceScene.tscn") 

# Called when the node enters the scene tree for the first time.
func passEvidence(texture : Texture, string : String, string2 : String) -> void:
	var newEvidence = evidence.instantiate();
	newEvidence.init(texture,string, string2)
	self.add_child(newEvidence)
