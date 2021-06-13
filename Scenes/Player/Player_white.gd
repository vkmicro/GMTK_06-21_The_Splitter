extends KinematicBody2D


enum color {combined, white, black} #0 = combined, 1 = white, 2 = black
var current_color = 0
var char2 

var fall_through_floor = false
var idle = true
var splitting = false
var splitting_animation = false
var split = false
var create_2nd_char = false
var player_white_can_move = false

var velocity = Vector2.ZERO
var speed = 250
var jump_strength = 400
var gravity = 700

onready var sprite = $AnimatedSprite

func _ready():
	if(Globals.split):
		show()
	else:
		hide()

func get_input():
	if(player_white_can_move):
		if Input.is_action_pressed("left"):
			sprite.play("move_white")
			idle = false
			velocity.x = -speed
			
		if Input.is_action_pressed("right"):
			sprite.play("move_white")
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
		sprite.play("idle_white")
	
	if(splitting):
		sprite.play("split")
#		print("splitting")
		splitting = false

	
	if(Globals.split):
		show()
	else:
		hide()


func _on_AnimatedSprite_animation_finished():
	pass
##	print("animation finished")
#	if(sprite.animation == "split"):
#		create_2nd_char = true
#		Globals.can_split = false
#		splitting_animation = false
#		Globals.split = true
#

func combine():
	Globals.can_split = true
	Globals.split = false
	Globals.currently_controlling = 0
