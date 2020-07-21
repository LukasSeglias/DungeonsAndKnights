extends Node2D
class_name Weapon

onready var animationPlayer = $AnimationPlayer
onready var sound = $AttackSound

signal weapon_hurts(value)

var direction = null setget set_direction
var _damage = 0
export (bool) var playingAttackAnimation = false

# Prefix like "Stab" to full animation name like "StabLeft" or "StabRight
export (String) var attackAnimationNamePrefix = "Stab"

func attack(damage):
	_damage = damage
	
	if !playingAttackAnimation:
		_playAttackAnimation()
	
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
		animationPlayer.play(attackAnimationNamePrefix + "Left")
	if direction == Direction.RIGHT:
		animationPlayer.play(attackAnimationNamePrefix + "Right")

func _playAttackSound():
	sound.play()

func set_direction(value):
	if direction != value:
		direction = value
		_playIdleAnimation()
