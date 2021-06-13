extends Control

var credits_clicked_restart = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Close_game_pressed():
	get_tree().quit()


func _on_Restart_game_pressed():
	credits_clicked_restart = true
	hide()
	get_tree().change_scene("res://Scenes/Main/Game_main.tscn")
