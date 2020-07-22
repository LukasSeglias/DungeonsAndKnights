extends Node2D

export(NodePath) var interactionTargetPath

var interactionTarget


# Called when the node enters the scene tree for the first time.
func _ready():
	interactionTarget = get_node(interactionTargetPath)

func switchOn(on):
	interactionTarget.switchOn(on)
	for child in get_children():
		if on:
			child.switchOn()
		else:
			child.switchOff()
