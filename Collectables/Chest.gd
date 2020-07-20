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
			body.collectCoins(amount)
		elif content == ChestContent.POTION_HEAL:
			body.collectPotion(PotionType.HEAL, amount)

	else:
		animationPlayer.play("empty_open")
