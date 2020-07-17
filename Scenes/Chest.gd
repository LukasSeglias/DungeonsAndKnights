extends StaticBody2D

export var open = false setget set_open
export(int) var coins = 50

onready var area = $Area2D
onready var animationPlayer = $AnimationPlayer
onready var chestOpeningAudio = $ChestOpeningAudio

func _ready():
	area.connect("body_entered", self, "_on_body_entered")
	area.connect("body_exited", self, "_on_body_exited")


func _on_body_entered(body):
	if(body.is_in_group("Player")):
		body.enterChest(self)


func _on_body_exited(body):
	if(body.is_in_group("Player")):
		body.exitChest(self)

func open(body):
	if(!open):
		open = true
		chestOpeningAudio.play()
		if(coins > 0):
			animationPlayer.play("full_open")
			body.collectCoins(coins)
		else:
			animationPlayer.play("empty_open")

func set_open(value):
	open = value
