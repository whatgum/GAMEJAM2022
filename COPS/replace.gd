extends Area2D


var evidenceScene = load("res://evidenceScene.tscn")


func _on_area_2d_body_entered(body):
	var newEvidence = evidenceScene.instantiate()
	newEvidence.init(body.get_parent()._texture,body.get_parent()._text, body.get_parent()._text2)
	var evidences = [newEvidence]
	get_parent().init(evidences)
	body.get_parent().queue_free()
	
