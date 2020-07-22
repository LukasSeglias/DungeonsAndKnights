extends Node2D

export(bool) var openManually = false
export(bool) var open = false

onready var animationPlayer = $AnimationPlayer

func _ready():
	if open:
		open()

func interact(body):
	if open or !body.get_playerstats().has_any_key() or openManually:
		print("interaction disallowed")
		return
	open()
	body.get_playerstats().consume_key()

func open():
	open = true
	animationPlayer.play("open")

func close():
	open = false
	animationPlayer.play("close")
