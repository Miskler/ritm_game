extends Control

var style

var to_del = false
func _ready():
	global_position.y = 0
	size.y = get_node("/root/main_game/interface/main").size.y
	
	$back.material = $back.material.duplicate()
	$back.material.set_shader_parameter("width_parameter", 0.5)
	$back.material.set_shader_parameter("color", Color.GREEN)
	
	var tween = create_tween()
	tween.tween_property($back.material, "shader_parameter/width_parameter", 0.0, 2.0)
	await get_tree().create_timer(1.5).timeout
	var tween2 = create_tween()
	tween2.tween_property($back.material, "shader_parameter/color", Color.RED, 0.1)
	await tween2.finished
	to_del = true
	await tween.finished
	tween = create_tween()
	tween.tween_property(self, "scale:x", 0.0, 0.1)
	await tween.finished
	queue_free()

func _process(_delta):
	if to_del and $Area2D.get_overlapping_bodies().size() > 0:
		to_del = false
		get_node("/root/main_game/interface/main/health").damage()
		get_node("/root/main_game/interface/main/wave").start_damage(get_node("/root/main_game/player").global_position)
		var tween = create_tween()
		tween.tween_property($back.material, "shader_parameter/color:a", 0.0, 0.1)
