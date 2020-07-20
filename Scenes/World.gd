extends Node2D

onready var navigation = $Navigation2D
onready var line = $Line2D

func _on_Enemies_navigation_request(enemy, targetPosition):
	var path = navigation.get_simple_path(enemy.position, targetPosition, false)
	enemy.path_to_target = path
	line.points = path
