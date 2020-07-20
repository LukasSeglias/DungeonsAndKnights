extends Area2D

onready var coinAudio = $CoinAudio
onready var hitBox = $Area2D

func _ready():
	pass


func _on_body_entered(body):
	hitBox.disconnect("body_entered", self, "_on_body_entered")
	if(body.is_in_group("Player")):
		visible = false
		coinAudio.play()
		body.collect(CollectableType.COIN, 1)
	else:
		hitBox.connect("body_entered", self, "_on_body_entered")

func animationFinished():
	queue_free()
