extends Node2D

export(NodePath) var doorPath
export(bool) var closeIfSwitchOn

var door

func _ready():
	door = get_node(doorPath)

func switchOn(on):
	var open = on if not closeIfSwitchOn else !on
	if open:
		door.open()
	else:
		door.close()
