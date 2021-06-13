extends Node

var balance = 100
var currently_controlling = 0 # 0= combined, 1 = white, 2 = black
var split = false
var can_split = true
var create_2nd = false
var adjust_player_pos_post_merge = false
var died = false
var tp_here = Vector2.ZERO

func _ready():
	pass

func _process(delta):
	if(split):
		if(balance > -100):
			balance -= 5 * delta
	else:
		if(balance < 100):
			balance += 15 * delta
	if(balance <= 0):
		died = true
