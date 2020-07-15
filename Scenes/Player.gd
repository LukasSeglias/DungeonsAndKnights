extends KinematicBody2D

const FRICTION = 500
const ACCELERATION = 500
const MAX_SPEED = 100

var velocity = Vector2.ZERO
onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

func _ready():
	pass


func _process(delta):
	pass


func _physics_process(delta):
	var input = _getMovementInputVector()
	if input != Vector2.ZERO:
		if input.x > 0:
			sprite.flip_h = false
		elif input.x < 0:
			sprite.flip_h = true
		animationPlayer.play("RunLeft")
		velocity = velocity.move_toward(input * MAX_SPEED, ACCELERATION * delta)
	else:
		animationPlayer.play("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)


func _getMovementInputVector():
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
