extends Node2D
class_name Collectable

onready var area = $Area2D

signal taken(body)

func _on_body_entered(body):
	emit_signal("taken", body)

func disable():
	area.disconnect("body_entered", self, "_on_body_entered")
