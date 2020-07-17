extends HBoxContainer

onready var display = $Display

func _on_PlayerStats_coins_collected(coins):
	print("Display: " + String(coins))
	display.text = String(coins)
