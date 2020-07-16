extends StaticBody2D


export var full = true setget set_full
export var open = false setget set_open

onready var area = $Area2D
onready var animationPlayer = $AnimationPlayer


func _ready():
	area.connect("body_entered", self, "_on_body_entered")
	area.connect("body_exited", self, "_on_body_exited")


func _on_body_entered(body):
	if(body.is_in_group("Player")):
		body.enterChest(self)


func _on_body_exited(body):
	if(body.is_in_group("Player")):
		body.exitChest(self)

func open():
	if(!open):
		open = true
		if(full):
			animationPlayer.play("empty_open")
		else:
			animationPlayer.play("full_open")


func set_full(value):
	full = value


func set_open(value):
	open = value
