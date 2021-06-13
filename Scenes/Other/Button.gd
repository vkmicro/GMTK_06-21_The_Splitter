extends Node2D

#var player_in_range = false
var pressed = false

func _process(delta):
	if(!pressed):
		$Button_normal.show()
		$Button_pressed.hide()
	else:
		$Button_normal.hide()
		$Button_pressed.show()

func _on_Area2D_body_entered(body):
	if(!pressed):
		$AudioStreamPlayer2D.play()
	pressed = true
	


