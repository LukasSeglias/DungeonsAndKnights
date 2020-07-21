extends StaticBody2D

enum ChestContent {
	COINS,
	POTION_HEAL
}

export(int) var amount = 50
export(ChestContent) var content = ChestContent.COINS
export(bool) var hasRandomContent = false;
export(bool) var hasRandomAmount = false;
export(int) var randomAmountMin = 0
export(int) var randomAmountMax = 100

onready var animationPlayer = $AnimationPlayer

const CollectEffect = preload("res://Effects/CollectChestEffect.tscn")

var random = RandomNumberGenerator.new()
var opened = false

func _ready():
	random.randomize()

func interact(body):
	if opened:
		return
	
	content = _get_random_content() if hasRandomContent else content
	amount = _get_random_amount(randomAmountMin, randomAmountMax) if hasRandomAmount else amount
	
	get_parent().add_child(CollectEffect.instance())
	
	if(amount > 0):
		animationPlayer.play("full_open")
		
		if content == ChestContent.COINS:
			body.collect(CollectableType.COIN, amount)
		elif content == ChestContent.POTION_HEAL:
			body.collect(CollectableType.POTION_HEAL, amount)
	else:
		animationPlayer.play("empty_open")
	opened = true

func _get_random_content():
	return ChestContent.values()[random.randi() % ChestContent.size()] 

func _get_random_amount(minAmount : int, maxAmount : int):
	return random.randi_range(minAmount, maxAmount)
