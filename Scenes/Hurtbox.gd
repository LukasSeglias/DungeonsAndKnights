extends Area2D


signal was_hurt(damage)


func _on_Hurtbox_area_entered(area):
	if area.damage != null:
		emit_signal("was_hurt", area.damage)
