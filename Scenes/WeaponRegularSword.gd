extends Node2D


onready var animationPlayer = $AnimationPlayer


func _ready():
	pass


func attack():
	animationPlayer.play("Swing")
