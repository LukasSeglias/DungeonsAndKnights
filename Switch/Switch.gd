extends Node2D

export(int) var time = 0
export(NodePath) var interactionTargetPath

onready var timer = $Timer
onready var sprite = $Sprite
onready var collisionShape = $Area2D/CollisionShape2D
onready var tickTockSound = $AudioStreamPlayer

var interactionTarget

# Called when the node enters the scene tree for the first time.
func _ready():
	interactionTarget = get_node(interactionTargetPath)
	timer.wait_time = time

func _on_Area2D_body_entered(body):
	switchOn()
	interactionTarget.switchOn(true)
	
	if time > 0:
		tickTockSound.play()
		timer.start()
		
func _on_Timer_timeout():
	switchOff()
	interactionTarget.switchOn(false)
	tickTockSound.stop()

func switchOn():
	collisionShape.set_deferred("disabled",true)
	sprite.frame = 1
	
func switchOff():
	sprite.frame = 0
	collisionShape.set_deferred("disabled",false)
