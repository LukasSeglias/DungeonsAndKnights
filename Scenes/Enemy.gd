extends KinematicBody2D
class_name Enemy


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var detect_radius = 20
export (bool) var show_radius = true
export (int) var damage = 10
export (int) var speed = 500
export (int) var health = 100
export (int) var attack_delta = 1
export (String) var weapon_name

onready var animationPlayer = $AnimationPlayer
onready var detectionShape = $Visibility/DetectionShape
onready var sprite = $Sprite

var target
var velocity = Vector2.ZERO
var can_see = true
var vis_color = Color(.867, .91, .247, 0.1)
var weapon
var previous_attack = 0;

func wasAttacked(attacker, damage):
	print("Enemy attacked")
	if self == attacker || attacker.is_in_group("Enemy"):
		return
	health -= damage
	if health <= 0:
		queue_free()

func _ready():
	var shape = CircleShape2D.new()
	shape.radius = detect_radius
	detectionShape.shape = shape
	if !weapon_name.empty():
		_switchWeapon(load("res://" + weapon_name))

func _switchWeapon(weaponScene):
	if(weapon != null):
		remove_child(weapon)
		weapon.queue_free()
	weapon = weaponScene.instance()
	add_child(weapon)
	weapon.init(true)

func _physics_process(delta):
	update()
	
	if target:
		moveSpriteAgainstPlayer()
		var distance = measureDistanceToPlayer();
		if distance <= 20:
			previous_attack += delta
			if can_see && previous_attack >= attack_delta:
				previous_attack = 0
				animationPlayer.play("Idle")
				attack()
		else:
			goToPlayer(delta)
	else:
		animationPlayer.play("Idle")
		
func attack():
	if weapon != null:
		weapon.attack(damage)

func moveSpriteAgainstPlayer():
	var collision = (position - target.position).normalized()
	if collision.x >= 0:
		sprite.flip_h = true
		weapon.rotation_degrees = 90
	else:
		sprite.flip_h = false
		weapon.rotation_degrees = -90
	
func goToPlayer(delta):
	animationPlayer.play("Run")
	var velocity = (target.position - position).normalized() * speed * delta
	move_and_slide(velocity)
	
func measureDistanceToPlayer():
	var distance = position.distance_to(target.position)
	return distance
	
func _on_detection_shape_body_entered(body):
	# connect this to the "body_entered" signal
	if target || !body.is_in_group("Player"):
		return
	target = body
	
func _on_detection_shape_body_exited(body):
	# connect this to the "body_exited" signal
	if body == target:
		target = null
		
func _draw():
	if show_radius:
		draw_circle(Vector2(), detect_radius, vis_color)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
