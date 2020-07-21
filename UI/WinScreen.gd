extends MarginContainer

onready var statusBar = $VBoxContainer/StatusBar

func _ready():
	statusBar._on_PlayerStats_collectables_updated(PlayerState.collectables)

func _on_Timer_timeout():
	get_tree().change_scene("res://UI/MainMenu.tscn")
