extends Node2D
class_name Weapon

onready var animationPlayer = $AnimationPlayer
onready var sound = $AttackSound

signal weapon_hurts(value)

var direction = Direction.LEFT setget set_direction
var _damage = 0
export (bool) var playingAttackAnimation = false

func _ready():
	pass
	

func attack(damage):
	_damage = damage
	
	if !playingAttackAnimation:
		_playAttackAnimation()
		sound.play()
	
func hasAttacked(body):
	if body.is_in_group("Attackable") && _damage > 0:
		body.wasAttacked(get_parent(), _damage)

func attackFinished():
	print("attackFinished")
	_playIdleAnimation()

func _weaponHurts(value):
	emit_signal("weapon_hurts", value)

func _playIdleAnimation():
	if direction == Direction.LEFT:
		animationPlayer.play("IdleLeft")
	if direction == Direction.RIGHT:
		animationPlayer.play("IdleRight")

func _playAttackAnimation():
	if direction == Direction.LEFT:
		animationPlayer.play("StabLeft")
	if direction == Direction.RIGHT:
		animationPlayer.play("StabRight")

func set_direction(value):
	if direction != value:
		direction = value
		_playIdleAnimation()
