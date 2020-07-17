extends Area2D

onready var coinAudio = $CoinAudio
onready var hitBox = $CollisionShape2D

func _ready():
	connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body):
	if(body.is_in_group("Player")):
		hitBox.disabled = true
		visible = false
		coinAudio.play()
		body.collectCoin(self)

func animationFinished():
	queue_free()
