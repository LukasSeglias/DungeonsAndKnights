extends Node2D

export(int) var max_health = 100
export(int) var health setget set_health

onready var healthBar = $HealthBar

signal no_health

func _ready():
	healthBar.max_value = max_health
	healthBar.value = health

func set_health(value):
	health = value
	if healthBar != null:
		healthBar.value = health
	if health <= 0:
		emit_signal("no_health")
