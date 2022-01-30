extends Control



# Called when the node enters the scene tree for the first time.
func init(amts, verdict):
	get_child(0).get_child(0).text = "YOU WIN!"
	get_child(0).get_child(1).text = "[center]You managed to uncover all the evidence before the laywer arrived!\n" + "Evidence Gathered : " + String.num(amts[0]) + "\nAmount of abuse :" + String.num(amts[1]) +"\nAmount of Persuasion :" + String.num(amts[2]) +"\nVertict : " + verdict

func init2(amts, verdict):
	get_child(0).get_child(1).text = "[center]The Perps laywer showed up before you could discover the truth!\n" + "Evidence Gathered : " + String.num(amts[0]) + "\nAmount of abuse :" + String.num(amts[1]) +"\nAmount of Persuasion :" + String.num(amts[2]) +"\nVertict : " + verdict


func _on_button_pressed():
	get_tree().reload_current_scene()
