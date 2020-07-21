extends HBoxContainer


onready var coinText = $CoinText
onready var potionHealText = $PotionHealText
onready var keyText = $KeyText

var displays = {}
var _collectables = {}

func _ready():
	displays[CollectableType.COIN] = coinText
	displays[CollectableType.POTION_HEAL] = potionHealText
	displays[CollectableType.KEY] = keyText
	_on_PlayerStats_collectables_updated(_collectables)


func _on_PlayerStats_collectables_updated(collectables):
	_collectables = collectables
	if displays.size() > 0:
		for collectable in collectables.keys():
			displays[collectable].text = String(collectables[collectable])
