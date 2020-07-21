extends KinematicBody2D
class_name Enemy

export (int) var detect_radius = 20
export (bool) var show_radius = true
export (int) var damage = 10
export (int) var speed = 500
export (int) var attack_delta = 1

signal navigation_request(enemy, targetPosition)

onready var animationPlayer = $AnimationPlayer
onready var detectionShape = $Visibility/DetectionShape
onready var sprite = $Sprite
onready var stats = $Stats
onready var hurtbox = $Hurtbox
onready var weaponSlot = $WeaponSlot

const deathEffect = preload("res://Effects/DeathEffect.tscn")
const UPDATE_PATH_TO_TARGET_LIMIT = 30

var path_to_target : = PoolVector2Array()
var target
var velocity = Vector2.ZERO
var can_see = true
var vis_color = Color(.867, .91, .247, 0.1)
var previous_attack = 0;
var _update_path_to_target_request = 0


func _ready():
	var shape = CircleShape2D.new()
	shape.radius = detect_radius
	detectionShape.shape = shape
	stats.connect("no_health", self, "_on_Stats_no_health")
	hurtbox.connect("was_hurt", self, "_on_Hurtbox_was_hurt")

func _on_Stats_no_health():
	get_parent().add_child(deathEffect.instance())
	queue_free()


func _on_Hurtbox_was_hurt(damage):
	stats.health -= damage


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
				weaponSlot.attack(damage)
		else:
			goToPlayer(delta)
			_update_path_to_target()
	else:
		animationPlayer.play("Idle")


func moveSpriteAgainstPlayer():
	var collision = (position - target.position).normalized()
	
	if collision.x > 0:
		sprite.flip_h = true
		weaponSlot.direction = Direction.LEFT
	elif collision.x < 0:
		sprite.flip_h = false
		weaponSlot.direction = Direction.RIGHT
	else:
		pass # do not flip


func goToPlayer(delta):
	if path_to_target.size() > 0:
		animationPlayer.play("Run")
		move_along_path(path_to_target, speed * delta, delta)
	#var velocity = (target.position - position).normalized() * speed * delta
	#move_and_slide(velocity)


func move_along_path(path: PoolVector2Array, distance : float, delta : float):
	var start_point = position
	for i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			var velocity = (path[0] - start_point).normalized() * speed * delta
			move_and_slide(velocity)
			#position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		#elif distance < 0.0:
			#position = path[0]
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)


func measureDistanceToPlayer():
	var distance = position.distance_to(target.position)
	return distance
	
func _on_detection_shape_body_entered(body):
	# connect this to the "body_entered" signal
	if target || !body.is_in_group("Player"):
		return
	_on_player_detected(body)

func _on_player_detected(body):
	target = body
	_navigationRequest()

func _navigationRequest():
	emit_signal("navigation_request", self, target.position)

func _update_path_to_target():
	_update_path_to_target_request += 1
	if _update_path_to_target_request > UPDATE_PATH_TO_TARGET_LIMIT:
		_update_path_to_target_request = 0
		print("Update path to target")
		_navigationRequest()

func _on_detection_shape_body_exited(body):
	# connect this to the "body_exited" signal
	if body == target:
		target = null
		
func _draw():
	if show_radius:
		draw_circle(Vector2(), detect_radius, vis_color)
