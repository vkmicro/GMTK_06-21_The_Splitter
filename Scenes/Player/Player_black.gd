extends KinematicBody2D

var player_black_can_move = false
var idle = false
var velocity = Vector2.ZERO
var speed = 250
var jump_strength = 500
var gravity = 750
var splitting_animation = false
var splitting = false
var can_merge = false

onready var sprite = $AnimatedSprite

func _ready():
	if(Globals.split):
		show()
	else:
		hide()

func get_input():
	if(player_black_can_move):
		if Input.is_action_pressed("left"):
			sprite.play("move_black")
			idle = false
			velocity.x = -speed
			
		if Input.is_action_pressed("right"):
			sprite.play("move_black")
			idle = false
			velocity.x = speed
			
		if Input.is_action_pressed("jump"):
			idle = false
			if(is_on_floor()):
				velocity.y = -jump_strength


func _physics_process(delta):
	velocity.x = 0
	idle = true
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	

func _process(delta):
	if(idle and !splitting_animation):
		sprite.play("idle_black")
	
	if(splitting):
		sprite.play("split")
#		print("splitting")
		splitting = false
		
	if(Globals.split):
		show()
	else:
		hide()
	


func _on_AnimatedSprite_animation_finished():
#	print("animation finished")
	if(sprite.animation == "split"):
#		create_2nd_char = true
		Globals.can_split = false
		splitting_animation = false
		Globals.split = true
	

func combine():
	Globals.can_split = true
	Globals.split = false
	Globals.currently_controlling = 0
	Globals.adjust_player_pos_post_merge = true
#	finished_merging = true


func _on_combine_range_body_entered(body):
#	print("white is back, can merge?")
	if(can_merge and body.is_in_group("white_player")):
		sprite.play("split")
#		print("merge")
		combine()
		

func _on_combine_range_body_exited(body):
	if(body.is_in_group("white_player")):
#		print("white left initial range, can merge")
		can_merge = true
