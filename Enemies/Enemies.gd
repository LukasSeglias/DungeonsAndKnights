extends YSort

signal navigation_request(enemy, targetPosition)

func _ready():
	for child in get_children():
		if child.has_signal("navigation_request"):
			child.connect("navigation_request", self, "_on_Enemy_navigation_request")

func _on_Enemy_navigation_request(enemy, targetPosition):
	emit_signal("navigation_request", enemy, targetPosition)
