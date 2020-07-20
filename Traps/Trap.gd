extends Node2D
class_name Trap

export(int) var activation_radius = 20

onready var activationShape = $ActivationArea/CollisionShape2D

func _ready():
	activationShape.shape.radius = activation_radius
