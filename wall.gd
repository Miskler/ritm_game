extends Control

@onready var round = $round
var style = "red"
func _ready():
	round.material = round.material.duplicate(true)
	
	var loop = create_tween().set_loops()
	loop.tween_property(round.material, "shader_parameter/turn", 1.0, 0.4)
	loop.tween_property(round.material, "shader_parameter/turn", 0.0, 0.0)
	
	round.material.set_shader_parameter("outer_radius", 0.0)
	round.material.set_shader_parameter("fill_ratio", 0.0)
	round.material.set_shader_parameter("inner_radius", 0.0)
	
	var tween = create_tween()
	tween.parallel().tween_property(round.material, "shader_parameter/outer_radius", 1.0, 0.5)
	tween.parallel().tween_property(round.material, "shader_parameter/fill_ratio", 1.0, 2.0)
	await get_tree().create_timer(0.2).timeout
	var tweenn = create_tween()
	tweenn.parallel().tween_property(round.material, "shader_parameter/inner_radius", 0.2, 0.3)
	
	await tween.finished
	
	if $Area2D.get_overlapping_bodies().size() > 0:
		get_node("/root/main_game/interface/main/health").damage()
		get_node("/root/main_game/interface/main/wave").start_damage(global_position+pivot_offset*4)
	
	tween = create_tween()
	tween.parallel().tween_property(round.material, "shader_parameter/outer_radius", 0.0, 0.1)
	
	await tween.finished
	
	queue_free()
