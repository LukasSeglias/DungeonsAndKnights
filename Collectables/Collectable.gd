extends StaticBody2D
class_name Collectable

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var sound = $CollectableSound

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body):
	if(body.is_in_group("Player")):
		body.enterCollectable(self)


func _on_body_exited(body):
	if(body.is_in_group("Player")):
		body.exitCollectable(self)

func can_take():
	return true;
	
func taken(body):
	pass

func take(body):
	if(can_take()):
		sound.play()
		taken(body);
