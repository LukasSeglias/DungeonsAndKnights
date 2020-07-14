extends KinematicBody2D

const FRICTION = 1000
const ACCELERATION = 1000
const MAX_SPEED = 200

var velocity = Vector2.ZERO

func _ready():
	pass


func _process(delta):
	pass


func _physics_process(delta):

	var input = _getMovementInputVector()
	if input != Vector2.ZERO:
		velocity = velocity.move_toward(input * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)


func _getMovementInputVector():
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
