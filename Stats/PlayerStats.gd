extends Node2D

onready var potionDrinkSound = $PotionDrinkSound

var collectables = {
	CollectableType.COIN: 0,
	CollectableType.POTION_HEAL: 0,
	CollectableType.KEY: 0
}

signal collectables_updated(collectables)

func collect(collectableType, amount):
	collectables[collectableType] += amount
	_emit_change()

func takePotion(potion):
	var potionAmount = collectables[potion]
	if potionAmount > 0:
		potionDrinkSound.play()
		collectables[potion] = potionAmount - 1
		_emit_change()
		return 1
	return 0

func has_any_key():
	return collectables[CollectableType.KEY] > 0

func consume_key():
	collectables[CollectableType.KEY] = collectables[CollectableType.KEY] -1
	_emit_change()

func _emit_change():
	emit_signal("collectables_updated", collectables)
