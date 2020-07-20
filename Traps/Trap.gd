extends Node2D
class_name Trap

export(int) var activation_radius = 10

onready var hitBox = $Hitbox
onready var trapSound = $TrapSound
onready var activationShape = $ActivationArea/CollisionShape2D

func _ready():
	activationShape.shape.radius = activation_radius

func disableHitBox(disabled):
	hitBox.disabled = disabled

func playSound():
	trapSound.play()
