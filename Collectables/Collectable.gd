extends StaticBody2D
class_name Collectable


onready var sound = $CollectableSound

var alreadyTaken = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body):
	if(body.is_in_group("Player")):
		body.enterCollectable(self)


func _on_body_exited(body):
	if(body.is_in_group("Player")):
		body.exitCollectable(self)
	
func taken(body):
	pass

func take(body):
	if not alreadyTaken:
		alreadyTaken = true
		sound.play()
		taken(body);
