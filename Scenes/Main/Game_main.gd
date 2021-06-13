extends Node2D

onready var player = preload("res://Scenes/Player/Player.tscn")
onready var player1 = $Player
var start_tp_timer = false
var can_teleport = true

var in_credits = false

func _ready():
	pass
#	print($CanvasLayer/bg_music.playing)
	
func _process(delta):
	
	if(Globals.balance <= -100):
		$CanvasLayer/Control2/Game_over_popup.show()
#		print("game over")
	
	$CanvasLayer/Control2/Shader_main.get_material().set_shader_param("balance", 1 - float(Globals.balance/100))
#	print("1 - float(Globals.balance/100) ", 1 - float(Globals.balance/100))
	if(Globals.split):
#		print("white pos: ", $Player_white.position)
		if(Input.is_action_just_pressed("switch_control")):
#			print("switch control")
#			print("current control: ", Globals.currently_controlling, " switch control to: ")
			if(Globals.currently_controlling == 0 or Globals.currently_controlling == 2):
#				print("control white")
				Globals.currently_controlling = 1 # 0= combined, 1 = white, 2 = black
				$Player_white.player_white_can_move = true
				$Player_black.player_black_can_move = false
				
				$Player_white/Camera_white.current = true
				$Player_black/Camera_black.current = false
				$Player/Camera_merged.current = false
				
			elif(Globals.currently_controlling == 0 or Globals.currently_controlling == 1):
#				print("control black")
				Globals.currently_controlling = 2
				$Player_white.player_white_can_move = false
				$Player_black.player_black_can_move = true
				
				$Player_white/Camera_white.current = false
				$Player_black/Camera_black.current = true
				$Player/Camera_merged.current = false
		
		
		#Teleportation feature
		if(Input.is_action_pressed("teleport_to_me") and can_teleport):
			$teleport_timer_progress.value = $teleport_timer.time_left
			$teleport_build_up.amount += 5
			if(!start_tp_timer):
				start_tp_timer = true
#				print("teleport countdown started")
				$teleport_timer.start()
				$teleport_timer_progress.show()
				$teleport_build_up.show()
				$teleport_timer_progress.value = $teleport_timer.time_left
				if($Player_white.player_white_can_move):
					$teleport_timer_progress.set_position($Player_white.position)
					$teleport_build_up.position = $Player_white.position
#					print("teleport effect: ", $Player/teleport_build_up.position, " ", $Player_white.position)
				else:
					$teleport_timer_progress.set_position($Player_black.position)
					$teleport_build_up.position = $Player_black.position
	#				$teleport_timer_progress.position.y = $Player_black.position.y - 16

		if(Input.is_action_just_released("teleport_to_me") and start_tp_timer):
			print("teleport cancelled")
			$teleport_timer.stop()
			$teleport_timer.wait_time = 2
			start_tp_timer = false
			$teleport_build_up.hide()
			$teleport_timer_progress.hide()
			
		#end teleportation feature



	else: #no longer split, merged together again
		if(Globals.adjust_player_pos_post_merge):
#			print("no longer split, combined back together")
			player1.position.x = $Player_black.position.x
			player1.position.y = $Player_black.position.y - 8
			Globals.adjust_player_pos_post_merge = false
				
		$Player_white/Camera_white.current = false
		$Player_black/Camera_black.current = false
		$Player/Camera_merged.current = true
		
	if(Globals.create_2nd): #if can't split that means we've split
#		print("split up")
		$Player_white.position.x = player1.position.x + 16
		$Player_white.position.y = player1.position.y
		$Player_black.position.x = player1.position.x - 16
		$Player_black.position.y = player1.position.y
		Globals.currently_controlling = 1
		$Player_white.player_white_can_move = true
		$Player_black.player_black_can_move = false
		Globals.create_2nd = false
		
		$Player_white/Camera_white.current = true
		$Player_black/Camera_black.current = false
		$Player/Camera_merged.current = false


	#levels doors and buttons
	
	#Level1
	if($Levels/L1/Button1.pressed and $Levels/L1/Button2.pressed):
		$Levels/L1/Exit_gate1.open = true
		if ($Levels/L1/Exit_gate1.player_at_next_zone):
			if(Globals.split):
				$Player_black.position = $Levels/L1/Exit_gate1.position
				$Player_white.position = $Levels/L1/Exit_gate1.position
				$Player.position = $Levels/L1/Exit_gate1.position
				$Player.position = $Levels/L1/Exit_gate1.position
			$Levels/L1/Exit_gate1.player_at_next_zone = false
			$Levels/L1/Exit_gate1/Area2D/player_passed_gate.queue_free()
	#level2
	if($Levels/L2/Button.pressed and $Levels/L2/Button2.pressed):
		$Levels/L2/Exit_gate.open = true
		if ($Levels/L2/Exit_gate.player_at_next_zone):
			if(Globals.split):
				$Player_black.position = $Levels/L2/Exit_gate.position
				$Player_white.position = $Levels/L2/Exit_gate.position
				$Player.position = $Levels/L2/Exit_gate.position
				$Player.position = $Levels/L2/Exit_gate.position
			$Levels/L2/Exit_gate.player_at_next_zone = false
			$Levels/L2/Exit_gate/Area2D/player_passed_gate.queue_free()
	#level3
	if($Levels/L3/Button.pressed):
		$Levels/L3/Exit_gate.open = true
		if ($Levels/L3/Exit_gate.player_at_next_zone):
			if(Globals.split):
				$Player_black.position = $Levels/L3/Exit_gate.position
				$Player_white.position = $Levels/L3/Exit_gate.position
				$Player.position = $Levels/L3/Exit_gate.position
				$Player.position = $Levels/L3/Exit_gate.position
			$Levels/L3/Exit_gate.player_at_next_zone = false
			$Levels/L3/Exit_gate/Area2D/player_passed_gate.queue_free()
	#level4
	if($Levels/L4/Button.pressed):
		$Levels/L4/Exit_gate.open = true
		if ($Levels/L4/Exit_gate.player_at_next_zone):
#			if(Globals.split):
#				$Player_black.position = $Levels/L4/Exit_gate.position
#				$Player_white.position = $Levels/L4/Exit_gate.position
#				$Player.position = $Levels/L4/Exit_gate.position
#				$Player.position = $Levels/L4/Exit_gate.position
			$Levels/L4/Exit_gate.player_at_next_zone = false
			$Levels/L4/Exit_gate/Area2D/player_passed_gate.queue_free()
	#level5
	if($Levels/L5/Button.pressed and $Levels/L5/Button2.pressed and $Levels/L5/Button3.pressed):
		$Levels/L5/Exit_gate.open = true
		if ($Levels/L5/Exit_gate.player_at_next_zone):
#			if(Globals.split):
#				var gateL5pos = Vector2(-322, 188)
#				$Player_black.position = gateL5pos
#				$Player_white.position = gateL5pos
#				$Player.position = gateL5pos
#				$Player.position = gateL5pos
			$Levels/L5/Exit_gate.player_at_next_zone = false
			$Levels/L5/Exit_gate/Area2D/player_passed_gate.queue_free()
#	#level6
	if($Levels/L6/Button.pressed and $Levels/L6/Button2.pressed):
		$Levels/L6/Exit_gate.open = true
		if ($Levels/L6/Exit_gate.player_at_next_zone):
#			if(Globals.split):
#				$Player_black.position = $Levels/L6/Exit_gate.position
#				$Player_white.position = $Levels/L6/Exit_gate.position
#				$Player.position = $Levels/L6/Exit_gate.position
#				$Player.position = $Levels/L6/Exit_gate.position
			$Levels/L6/Exit_gate.player_at_next_zone = false
			$Levels/L6/Exit_gate/Area2D/player_passed_gate.queue_free()
#	#level7
#	if($Levels/L7/Button.pressed):
#		$Levels/L7/Exit_gate.open = true
#		if ($Levels/L7/Exit_gate.player_at_next_zone):
#			if(Globals.split):
#				var gateL7pos = Vector2(-1119, -35)
#				$Player_black.position = Vector2(-1120, $Levels/L7/Exit_gate.position.y + 5)
##				$Player_black.position = Vector2(-1130, -33)
#				$Player_white.position = Vector2(-1120, $Levels/L7/Exit_gate.position.y + 5)
#				$Player.position = $Player_black.position
#				$Player.position = $Player_white.position
#				$Player.position = $Levels/L7/Exit_gate.position
#				$Player.position = $Player_black.position
#				$Player.position = $Player_black.position
##				print($Levels/L7/Exit_gate.position.y)
###				print("set player pos: ", $Player_white.position.y, " ", $Levels/L7/Exit_gate.position.y)
##				print($Player.position)
##				print($Player_white.position)
##				print($Player_black.position)
#				print("gate pos: ", $Levels/L7/Exit_gate.position)
##				$Player_black.position = $Levels/L7/Exit_gate.position
##				$Player_white.position = $Levels/L7/Exit_gate.position
#			$Levels/L7/Exit_gate.player_at_next_zone = false
#			$Levels/L7/Exit_gate/Area2D/player_passed_gate.queue_free()
#	#level8-end
	if($Levels/L8_end/Button.pressed and $Levels/L8_end/Button2.pressed):
		$Levels/L8_end/Exit_gate_8.open = true
		if ($Levels/L8_end/Exit_gate_8.player_at_next_zone):
#			if(Globals.split):
#				$Player_black.position = $Levels/L8_end/Exit_gate_8.position
#				$Player_white.position = $Levels/L8_end/Exit_gate_8.position
#				$Player.position = $Player_black.position
#				$Player.position = $Player_black.position
			$Levels/L8_end/Exit_gate_8.player_at_next_zone = false
			$Levels/L8_end/Exit_gate_8/Area2D/player_passed_gate.queue_free()


#end process


func _on_teleport_timer_timeout():
	can_teleport = false
	$teleport_cooldown.start()
	$teleport_timer_progress.hide()
	$teleport_build_up.hide()
	if($Player_white.player_white_can_move):
		$Player_black.position.x = $Player_white.position.x
		$Player_black.position.y = $Player_white.position.y - 4
	else:
		$Player_white.position.x = $Player_black.position.x
		$Player_white.position.y = $Player_black.position.y - 4
	
	start_tp_timer = false
	$teleport_timer.stop()
	$teleport_timer.wait_time = 1
	$teleport_timer.stop()
	$teleport_build_up.hide()
	$teleport_timer_progress.hide()


func _on_teleport_cooldown_timeout():
	can_teleport = true


func _on_Exit_pressed():
	get_tree().quit()

func _on_Credits_pressed():
	get_tree().change_scene("res://Scenes/Credits/Credits.tscn")
	

func _on_Restart_pressed():
	get_tree().reload_current_scene()
