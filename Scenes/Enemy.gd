extends KinematicBody2D
class_name Enemy

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
onready var stats = $Stats
onready var hurtbox = $Hurtbox
onready var hitbox = $Hitbox
onready var hitboxPositionLeft = $HitboxPosition/Left
onready var hitboxPositionRight = $HitboxPosition/Right

var target
var velocity = Vector2.ZERO
var can_see = true
var vis_color = Color(.867, .91, .247, 0.1)
var weapon
var previous_attack = 0;


func _ready():
	var shape = CircleShape2D.new()
	shape.radius = detect_radius
	detectionShape.shape = shape
	if !weapon_name.empty():
		_switchWeapon(load("res://" + weapon_name))
	stats.connect("no_health", self, "_on_Stats_no_health")
	hurtbox.connect("was_hurt", self, "_on_Hurtbox_was_hurt")


func _on_Stats_no_health():
	queue_free()


func _on_Hurtbox_was_hurt(damage):
	stats.health -= damage


func _switchWeapon(weaponScene):
	if(weapon != null):
		remove_child(weapon)
		weapon.queue_free()
	weapon = weaponScene.instance()
	add_child(weapon)

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
	
	if collision.x > 0:
		sprite.flip_h = true
		weapon.direction = Direction.LEFT
		hitbox.position = hitboxPositionLeft.position
	elif collision.x < 0:
		sprite.flip_h = false
		weapon.direction = Direction.RIGHT
		hitbox.position = hitboxPositionRight.position
	else:
		pass # do not flip
	
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
