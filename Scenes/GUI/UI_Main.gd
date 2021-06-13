extends Control

onready var balance = $Balance

func _ready():
	balance.value = 100

func _process(delta):
	balance.value = Globals.balance
