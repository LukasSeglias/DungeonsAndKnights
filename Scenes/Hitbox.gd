extends Area2D

onready var collisionshape = $CollisionShape2D

var damage = 10

var disabled setget _set_disabled


func _set_disabled(value):
	collisionshape.disabled = value
