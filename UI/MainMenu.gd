extends MarginContainer

func _ready():
	PlayerState.clear()
	
func _on_option_credits_pressed():
	get_tree().change_scene("res://UI/Credits.tscn")

func _on_option_new_game_pressed():
	get_tree().change_scene("res://Level/Level1.tscn")
