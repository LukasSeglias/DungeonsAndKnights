extends Collectable

export var open = false setget set_open
export(int) var coins = 50

onready var animationPlayer = $AnimationPlayer

func _ready():
	pass
	
func can_take():
	return !open;

func taken(body):
	open = true
	if(coins > 0):
		animationPlayer.play("full_open")
		body.collectCoins(coins)
	else:
		animationPlayer.play("empty_open")

func set_open(value):
	open = value
