extends Node2D

var open = false

onready var animationPlayer = $AnimationPlayer
onready var blockingBox = $BlockingBox

func interact(body):
	if open or !body.get_playerstats().has_any_key():
		return
	open()
	body.get_playerstats().consume_key()

func open():
	open = true
	animationPlayer.play("open")
	blockingBox.disabled = true
