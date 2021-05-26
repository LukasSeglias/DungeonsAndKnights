extends Particles2D

var color setget color_set, color_get

func _on_animation_ended():
	queue_free()

func color_set(new_color):
	color = new_color
	var material = ParticlesMaterial.new()
	material.gravity = Vector3(0, 25, 0)
	material.spread = 180
	material.initial_velocity = 20
	material.initial_velocity_random = 1
	material.scale = 2.0
	material.scale_random = 1
	if color == 'green':
		material.color = Color(0, 1, 0, 1)
	else:
		material.color = Color(1, 0, 0, 1)
	process_material = material
	
func color_get():
	return color
