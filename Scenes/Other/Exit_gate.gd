extends Node2D

var open = false
var next_level = 2
var player_at_next_zone = false
var remote_collision = false
var disabled = false

func _process(delta):
	if(!open):
		$Gate.show()
	else:
		$Gate.hide()
		$RigidBody2D/CollisionShape2D.disabled = true
#		print("gate open, disable collision: ")
#		print("gate open, hide it")
#	if(player_at_next_zone):
#		print("Delete the fucking zone")
#		$Area2D/player_passed_gate.disabled = true
#		$Area2D/player_passed_gate.queue_free()


func _on_Area2D_body_entered(body):
	#TODO > go to next level
	if(open):
		if(body.is_in_group("player")):
			print("player passed the gate")
			player_at_next_zone = true
#			$Area2D.queue_free()
			
			
#			queue_free()
#			$Area2D/player_passed_gate.disabled = true
	
