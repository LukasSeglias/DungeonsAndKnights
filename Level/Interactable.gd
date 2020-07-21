extends Node2D

export(NodePath) var interactionTargetPath

var interactionTarget

func _ready():
	interactionTarget = get_node(interactionTargetPath)

func _on_body_entered(body):
	body.enterInteractable(interactionTarget)

func _on_body_exited(body):
	body.exitInteractable(interactionTarget)
