extends Node2D

onready var animationPlayer = $AnimationPlayer
onready var hurtBox = $HurtBox
onready var swordAudio = $SwordAudio

var _damage = 0

func _ready():
	pass
	

func attack(damage):
	_damage = damage
	animationPlayer.play("Swing")
	swordAudio.play()
	
func hasAttacked(body):
	if body.is_in_group("Attackable") && _damage > 0:
		body.wasAttacked(get_parent(), _damage)
