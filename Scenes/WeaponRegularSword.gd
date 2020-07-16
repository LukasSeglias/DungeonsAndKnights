extends Node2D

onready var animationPlayer = $AnimationPlayer
onready var hurtBox = $HurtBox

var _damage = 0

func _ready():
	pass


func init(isEnemy):
	var layerBit = 1
	var maskBit = 0
	if isEnemy:
		layerBit = 0
		maskBit = 1
	hurtBox.set_collision_layer_bit(2, true)
	hurtBox.set_collision_mask_bit(layerBit, false)
	hurtBox.set_collision_mask_bit(maskBit, true)
	

func attack(damage):
	_damage = damage
	animationPlayer.play("Swing")
	
func hasAttacked(body):
	if body.is_in_group("Attackable") && _damage > 0:
		body.wasAttacked(get_parent(), _damage)
