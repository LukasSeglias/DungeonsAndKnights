extends KinematicBody2D

const FRICTION = 500
const ACCELERATION = 500
const MAX_SPEED = 100

export (int) var health = 100
export (int) var damage = 20

export (int) var weaponDistance = 10

var velocity = Vector2.ZERO
onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var weaponSlot = $WeaponSlot
onready var stats = $Stats
onready var hitbox = $Hitbox

var nearbyChest

func _ready():
	pass


func _process(delta):
	pass


func _physics_process(delta):
	var input = _getMovementInputVector()
	_playMovementAnimation(input)
	_moveBasedOnInput(delta, input)
	_handleActionInput()
	if(Input.is_action_just_pressed("attack")):
		weaponSlot.attack(damage)


func _handleActionInput():
	if(Input.is_action_just_pressed("action")):
		if(nearbyChest != null):
			nearbyChest.open()


func _getMovementInputVector():
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()


func _moveBasedOnInput(delta, input):
	if input != Vector2.ZERO:
		velocity = velocity.move_toward(input * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)


func _playMovementAnimation(input):
	if input != Vector2.ZERO:
		if input.x > 0:
			sprite.flip_h = false
			weaponSlot.direction = Direction.RIGHT
		elif input.x < 0:
			sprite.flip_h = true
			weaponSlot.direction = Direction.LEFT
		else:
			pass # do not flip
		animationPlayer.play("RunLeft")
	else:
		animationPlayer.play("Idle")


func collectCoin(coin):
	print("Coin collected!")


func enterChest(chest):
	if(!chest.open):
		print("Near chest!")
		nearbyChest = chest


func exitChest(chest):
	if(chest == nearbyChest):
		print("Leave chest!")
		nearbyChest = null


func _on_Hurtbox_was_hurt(damage):
	stats.health -= damage


func _on_Stats_no_health():
	get_tree().change_scene("res://Scenes/GameOver.tscn")
