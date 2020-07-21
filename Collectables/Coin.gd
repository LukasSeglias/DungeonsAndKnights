extends Area2D

const CollectEffect = preload("res://Effects/CollectCoinEffect.tscn")

func _on_Collectable_taken(body):
	body.collect(CollectableType.COIN, 1)
	get_parent().add_child(CollectEffect.instance())
	queue_free()
