extends HBoxContainer


onready var coinText = $CoinText
onready var potionHealText = $PotionHealText

var displays = {}

func _ready():
	displays[CollectableType.COIN] = coinText
	displays[CollectableType.POTION_HEAL] = potionHealText


func _on_PlayerStats_collectables_updated(collectables):
	for collectable in collectables.keys():
		displays[collectable].text = String(collectables[collectable])
