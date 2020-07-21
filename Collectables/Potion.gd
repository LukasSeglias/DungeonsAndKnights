extends Node2D
class_name Potion

enum PotionType {
	HEAL
}
export(PotionType) var potionType = PotionType.HEAL

const CollectEffect = preload("res://Effects/CollectPotionEffect.tscn")

func _on_Collectable_taken(body):
	body.collect(_to_collectable_type(potionType), 1)
	get_parent().add_child(CollectEffect.instance())
	queue_free()

func _to_collectable_type(potionType):
	if potionType == PotionType.HEAL:
		return CollectableType.POTION_HEAL
	else:
		return null
