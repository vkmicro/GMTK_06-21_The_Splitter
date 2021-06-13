extends Node2D

var player_at_next_zone = false
var disable_self = false


func _on_Area2D_body_entered(body):
#	print("body entered")
	if(body.is_in_group("player")):
		print("TP other player to me")
		player_at_next_zone = true
		disable_self = true

func _process(delta):
	if(disable_self):
		$Area2D/CollisionShape2D.disabled = true
