extends Collectable

enum ChestContent {
	COINS,
	POTION_HEAL	
}

export(int) var amount = 50
export(ChestContent) var content = ChestContent.COINS

onready var animationPlayer = $AnimationPlayer

func _ready():
	pass

func taken(body):
	if(amount > 0):
		animationPlayer.play("full_open")
		if content == ChestContent.COINS:
			body.collect(CollectableType.COIN, amount)
		elif content == ChestContent.POTION_HEAL:
			body.collect(CollectableType.POTION_HEAL, amount)

	else:
		animationPlayer.play("empty_open")
