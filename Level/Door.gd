extends Node2D

var open = false

onready var animationPlayer = $AnimationPlayer
onready var blockingBox = $BlockingBox

func interact(body):
	if open:
		return
	open()

func open():
	open = true
	animationPlayer.play("open")
	blockingBox.disabled = true
