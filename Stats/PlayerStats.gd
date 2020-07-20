extends Node2D

onready var potionDrinkSound = $PotionDrinkSound

var collectables = {
	CollectableType.COIN: 0,
	CollectableType.POTION_HEAL: 0
}

signal collectables_updated(collectables)

func collect(collectableType, amount):
	collectables[collectableType] += amount
	emit_signal("collectables_updated", collectables)
	
func takePotion(potion):
	var potionAmount = collectables[potion]
	if potionAmount > 0:
		potionDrinkSound.play()
		collectables[potion] = potionAmount - 1
		emit_signal("collectables_updated", collectables)
		return 1
	return 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
