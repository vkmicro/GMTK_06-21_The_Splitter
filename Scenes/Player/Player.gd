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

var velocity = Vector2.ZERO
var speed = 250
var jump_strength = 400
var gravity = 700

onready var sprite = $AnimatedSprite


func get_input():
	
	if Input.is_action_pressed("left"):
		sprite.play("move_combined")
		idle = false
		velocity.x = -speed
		
	if Input.is_action_pressed("right"):
		sprite.play("move_combined")
		idle = false
		velocity.x = speed
			
	if Input.is_action_pressed("jump"):
		idle = false
		if(is_on_floor()):
			velocity.y = -jump_strength
				
	
	if Input.is_action_just_pressed("split"):
		if(Globals.can_split):
			split = true
			splitting = true
			splitting_animation = true
			Globals.create_2nd = true

func _physics_process(delta):
	velocity.x = 0
	idle = true
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	

func _process(delta):
	if(idle and !splitting_animation):
		if(current_color == color.combined):
			sprite.play("idle_combined")
		elif(current_color == color.white):
			sprite.play("idle_white")
		elif(current_color == color.black):
			sprite.play("idle_black")
	
	if(splitting):
		sprite.play("split")
#		print("splitting")
		splitting = false
		$split_sound.play()
		
		
	if(!Globals.split):
		show()
		$Body/CollisionShape2D.disabled = false
	else:
		hide()
		$Body/CollisionShape2D.disabled = true
		
	
	if(!idle):
		$move_sound.play()


func _on_AnimatedSprite_animation_finished():
#	print("animation finished")
	if(sprite.animation == "split"):
		create_2nd_char = true
		Globals.can_split = false
		splitting_animation = false
		Globals.split = true
		print("globals.split = true")
		Globals.currently_controlling = 1
		
		

#func combine():
#	Globals.can_split = true
#	Globals.split = false
#	Globals.currently_controlling = 0
