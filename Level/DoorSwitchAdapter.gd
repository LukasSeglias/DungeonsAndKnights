extends Node2D

export(NodePath) var doorPath

var door

func _ready():
	door = get_node(doorPath)

func switchOn(on):
	if on:
		door.open()
	else:
		door.close()
