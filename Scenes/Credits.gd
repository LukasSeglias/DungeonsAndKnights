extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	
	
func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		on_exit()

func on_exit(anim_name="unused"):
	print("finished")
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
