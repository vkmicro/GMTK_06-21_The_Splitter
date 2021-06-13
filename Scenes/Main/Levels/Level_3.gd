extends Node2D
var level3_gate_open = false

func _process(delta):
	for button in get_tree().get_nodes_in_group("buttons"):
		if(button.pressed):
			$Exit_gate.open = true
			level3_gate_open = true
#			print("button pressed, open the exit gate")
