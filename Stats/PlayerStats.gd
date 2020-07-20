extends Node2D

onready var potionDrinkSound = $PotionDrinkSound

var coins = 0
var potions = {
	PotionType.HEAL: 0
}

signal coins_collected(coins)
signal potion_updated(potions)

func collectCoin(amount):
	coins += amount
	emit_signal("coins_collected", coins)
	
func collectPotion(potion, amount):
	potions[potion] += amount
	emit_signal("potion_updated", potions)
	
func takePotion(potion):
	var potionAmount = potions[potion]
	if potionAmount > 0:
		potionDrinkSound.play()
		potions[potion] = potionAmount - 1
		emit_signal("potion_updated", potions)
		return 1
	return 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
