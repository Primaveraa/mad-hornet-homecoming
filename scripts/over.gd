extends Sprite

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		get_tree().change_scene("res://scenes/game.tscn")
		
	var joys = Input.get_connected_joysticks()
	if joys.size() > 0:
		var joy = joys[0]
		if Input.is_joy_button_pressed(joy, JOY_SONY_X):
			get_tree().change_scene("res://scenes/game.tscn")
			

	