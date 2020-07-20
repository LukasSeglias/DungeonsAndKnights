extends HBoxContainer


onready var display = $HealDisplay

var displays = {}

func _ready():
	displays[Potion.HEAL] = display

func _on_PlayerStats_potion_updated(potions):
	for potion in potions.keys():
		displays[potion].text = String(potions[potion])
