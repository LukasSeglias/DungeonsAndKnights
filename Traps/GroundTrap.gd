extends Trap

onready var animation = $AnimationPlayer

func _on_ActivationArea_body_entered(body):
	animation.play("TrapAnimation")

func _on_ActivationArea_body_exited(body):
	animation.stop()
	disableHitBox(true)
