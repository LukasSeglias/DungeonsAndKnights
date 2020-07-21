extends MarginContainer

var timer

func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(3)
	timer.connect("timeout", self, "on_change_scene")
	add_child(timer)
	timer.start()

func on_change_scene():
	remove_child(timer)
	get_tree().change_scene("res://UI/MainMenu.tscn")
