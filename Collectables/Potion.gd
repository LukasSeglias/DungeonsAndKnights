extends Collectable
class_name Potion

onready var hitBox = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func potion_type():
	return PotionType.HEAL

func taken(body):
	hitBox.disconnect("body_entered", self, "_on_body_entered")
	visible = false
	body.collectPotion(potion_type(), 1)

func _on_CollectableSound_finished():
	queue_free()
