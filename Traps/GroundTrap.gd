extends Node2D

onready var animation = $AnimationPlayer

func _on_ActivationArea_body_entered(body):
	animation.get_animation("TrapAnimation").set_loop(true)
	animation.play("TrapAnimation")

func _on_ActivationArea_body_exited(body):
	animation.get_animation("TrapAnimation").set_loop(false)
