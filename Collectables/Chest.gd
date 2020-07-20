extends Collectable

enum ChestContent {
	COINS,
	POTION_HEAL	
}

export var open = false setget set_open
export(int) var amount = 50
export(ChestContent) var content = ChestContent.COINS

onready var animationPlayer = $AnimationPlayer

func _ready():
	pass
	
func can_take():
	return !open;

func taken(body):
	open = true
	if(amount > 0):
		animationPlayer.play("full_open")
		if content == ChestContent.COINS:
			body.collectCoins(amount)
		elif content == ChestContent.POTION_HEAL:
			body.collectPotion(Potion.HEAL, amount)

	else:
		animationPlayer.play("empty_open")

func set_open(value):
	open = value
