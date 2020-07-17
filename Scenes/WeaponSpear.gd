extends Node2D


onready var animationPlayer = $AnimationPlayer
onready var hurtBox = $HurtBox
onready var spearAudio = $SpearAudio

var _damage = 0

func _ready():
	pass # Replace with function body.


func attack(damage):
	_damage = damage
	animationPlayer.play("Swing")
	spearAudio.play()
	
func hasAttacked(body):
	print("weapon attacked")
	if body.is_in_group("Attackable") && _damage > 0:
		body.wasAttacked(get_parent(), _damage)
