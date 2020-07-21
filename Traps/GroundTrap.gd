extends Node2D

export(bool) var oneWay = false

onready var animation = $AnimationPlayer
var animationPlayed = false

func _on_ActivationArea_body_entered(body):
	if not oneWay:
		animation.get_animation("TrapAnimation").set_loop(true)
		animation.play("TrapAnimation")
	elif not animationPlayed:
		animation.play("TrapAnimation_OneWay")
	animationPlayed = true

func _on_ActivationArea_body_exited(body):
	animation.get_animation("TrapAnimation").set_loop(false)
