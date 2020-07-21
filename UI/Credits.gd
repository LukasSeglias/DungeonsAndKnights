extends MarginContainer

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		on_exit()

func on_exit(anim_name="unused"):
	get_tree().change_scene("res://UI/MainMenu.tscn")
