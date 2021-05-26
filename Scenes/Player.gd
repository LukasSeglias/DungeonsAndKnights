extends KinematicBody2D

const FRICTION = 500
const ACCELERATION = 500
const MAX_SPEED = 100

export (int) var health = 100
export (int) var damage = 20
export (int) var weaponDistance = 10
export (bool) var isPlayable = true

var velocity = Vector2.ZERO
onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var weaponSlot = $WeaponSlot
onready var stats = $Stats
onready var hitbox = $Hitbox
onready var playerStats = $PlayerStats
onready var hurtSound = $HurtSound
onready var bloodPosition = $BloodPosition

const BloodEffect = preload("res://Effects/BloodEffect.tscn")

var nearbyInteractable

func _ready():
	weaponSlot.direction = Direction.RIGHT
	PlayerState.load(stats, playerStats)

func _process(delta):
	pass

func _physics_process(delta):
	var input = _getMovementInputVector()
	_playMovementAnimation(input)
	_moveBasedOnInput(delta, input)
	_handleInput()

func _handleInput():
	if not isPlayable:
		return
	_handleActionInput()
	if(Input.is_action_just_pressed("attack")):
		weaponSlot.attack(damage)

func _handleActionInput():
	if(Input.is_action_just_pressed("action")):
		if(nearbyInteractable != null):
			print("Interact!!")
			nearbyInteractable.interact(self)
	if(Input.is_action_just_pressed("potion_heal") &&
			stats.health < stats.max_health):
		var healPotion = playerStats.takePotion(CollectableType.POTION_HEAL)
		stats.health += healPotion * 50


func _getMovementInputVector():
	if isPlayable:
		return Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		).normalized()
	else:
		return Vector2.ZERO


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

func collect(collectableType, amount):
	playerStats.collect(collectableType, amount)

func save_properties():
	PlayerState.save(stats, playerStats)

func enterInteractable(interactable):
	print("Enter interactable")
	nearbyInteractable = interactable	

func exitInteractable(interactable):
	if(interactable == nearbyInteractable):
		nearbyInteractable = null

func _on_Hurtbox_was_hurt(damage):
	hurtSound.play()
	var blood = BloodEffect.instance()
	blood.color = 'red'
	bloodPosition.add_child(blood)
	stats.health -= damage

func _on_Stats_no_health():
	get_tree().change_scene("res://UI/GameOver.tscn")

func get_playerstats():
	return playerStats
