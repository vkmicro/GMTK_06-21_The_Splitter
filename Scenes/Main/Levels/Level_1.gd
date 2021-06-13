extends Node2D
var player_at_next_zone = false

func _process(delta):
	for button in get_tree().get_nodes_in_group("buttons"):
		if(button.pressed):
#			print("open gate")
			$Exit_gate.open = true
			
#			print("button pressed, open the exit gate")
	if($Exit_gate.player_at_next_zone):
		player_at_next_zone = true
