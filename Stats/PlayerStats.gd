extends Node2D


var coins = 0

signal coins_collected(coins)

func collectCoin(amount):
	coins += amount
	emit_signal("coins_collected", coins)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
