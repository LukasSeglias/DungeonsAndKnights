extends Node2D

export(String, FILE) var scene_file

func _ready():
	pass # Replace with function body.

func _on_Area_body_entered(body):
	body.save_properties()
	get_tree().change_scene(scene_file)
