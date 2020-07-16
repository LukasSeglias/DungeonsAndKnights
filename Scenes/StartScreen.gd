extends MarginContainer

var timer


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(3)
	timer.connect("timeout", self, "on_change_scene")
	add_child(timer)
	timer.start()
	
func on_change_scene():
	remove_child(timer)
	print("On change")
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
