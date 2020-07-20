extends Collectable
class_name Potion

enum PotionType {
	HEAL
}
export(PotionType) var potionType = PotionType.HEAL

onready var hitBox = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func taken(body):
	hitBox.disconnect("body_entered", self, "_on_body_entered")
	visible = false
	body.collect(_to_collectable_type(potionType), 1)
	
func _to_collectable_type(potionType):
	if potionType == PotionType.HEAL:
		return CollectableType.POTION_HEAL
	else:
		return null

func _on_CollectableSound_finished():
	queue_free()
