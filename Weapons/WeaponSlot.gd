extends Node2D

onready var hitbox = $Hitbox

export (String) var weapon_name = "WeaponSpear" setget _set_weapon_name

var weapon
var direction = null setget set_direction

onready var weaponPosition = $WeaponPosition
onready var hitboxPositionLeft = $HitboxPosition/Left
onready var hitboxPositionRight = $HitboxPosition/Right

func _ready():
	_switchWeapon(load("res://Weapons/" + weapon_name + ".tscn"))

func attack(damage):
	weapon.attack(damage)
	
func hasAttacked(body):
	weapon.hasAttacked(body)

func set_direction(value):
	if direction != value:
		direction = value
		weapon.set_direction(value)
		hitbox.disabled = true
		if value == Direction.LEFT:
			hitbox.position = hitboxPositionLeft.position
		else:
			hitbox.position = hitboxPositionRight.position

func _switchWeapon(weaponScene):
	if(weapon != null):
		weapon.disconnect("weapon_hurts", self, "_set_weapon_hurts")
		weaponPosition.remove_child(weapon)
		weapon.queue_free()
	weapon = weaponScene.instance()
	weaponPosition.add_child(weapon)
	weapon.connect("weapon_hurts", self, "_set_weapon_hurts")

func _set_weapon_name(name):
	weapon_name = name
	if weaponPosition != null:
		_switchWeapon(load("res://Weapons/" + weapon_name + ".tscn"))

func _set_weapon_hurts(value):
	print("_set_weapon_hurts: " + String(value))
	hitbox.disabled = !value
