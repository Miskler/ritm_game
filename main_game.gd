extends Control

func _ready():
	randomize()



var started_game = false
func spavn_event():
	if started_game:
		if $musik.musik_now >= $musik.musik_size:
			$interface.win_session()
		else:
			call($interface.select_style)

func red():
	if (randf_range(-1, 1) > 0 or $musik.musik_now < 13) and ($musik.musik_now < 38 or ($musik.musik_now > 67 and randf_range(-1, 1) > 0.2)):
		var pos = Vector2(randf_range($spavn_zone.size.x/1.8,$spavn_zone.size.x),randf_range($spavn_zone.position.y,$spavn_zone.size.y))
		if $musik.musik_now < 12 or $musik.musik_now > 67:
			pos = Vector2(randf_range(0,$spavn_zone.size.x),randf_range(0,$spavn_zone.size.y))
		
		var node = load("res://wall.tscn").instantiate()
		
		node.global_position = pos
		node.style = $interface.select_style
		
		$spavn_zone.add_child(node)
	elif randf_range(-1, 1) > 0:
		var pos = Vector2(0,randf_range($spavn_zone.position.y,$spavn_zone.size.y))
		
		var node = load("res://arrow.tscn").instantiate()
		
		node.global_position = pos
		node.style = $interface.select_style
		node.rotation_degrees = 90
		
		if $musik.musik_now > 38 and randf_range(-1, 1) > 0:
			node.rotation_degrees = -90
			node.global_position.x = $spavn_zone.size.x
		
		$spavn_zone.add_child(node)
	
	$spavn_event.wait_time = clamp($spavn_event.wait_time-0.002, 0.08, 1)
	$spavn_event.start()
