extends CharacterBody2D

var styl = ""
func start_game(style:String = "red"):
	$AnimationPlayer.play(style)
	started_game = true
	styl = style
func stop_game():
	$AnimationPlayer.play_backwards(styl)

var started_game = false
func _process(_delta):
	if not started_game: return
	
	var tween = create_tween()
	
	tween.tween_property(self, "global_position", get_global_mouse_position(), 0.2)
