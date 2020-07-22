extends Node2D

export(bool) var openManually = false

var open = false

onready var animationPlayer = $AnimationPlayer

func interact(body):
	print("interact")
	if open or !body.get_playerstats().has_any_key() or openManually:
		print("interaction disallowed")
		return
	open()
	body.get_playerstats().consume_key()

func open():
	print("open")
	open = true
	animationPlayer.play("open")

func close():
	print("close")
	open = false
	animationPlayer.play("close")
