extends KinematicBody2D

static func TRESHOLD():
	return 0.1

var velocity = 100

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var dir = Vector2(0, 0)
	var speed = velocity * delta
	
	if is_colliding():
		if get_collider().get_parent().get_name() != "bounds":
			get_tree().change_scene("res://scenes/GameOver.tscn")
	

	if Input.is_key_pressed(KEY_W):
		dir.y = -1
	if Input.is_key_pressed(KEY_S):
		dir.y = 1
	if Input.is_key_pressed(KEY_A):
		dir.x = -1
	if Input.is_key_pressed(KEY_D):
		dir.x = 1
	if Input.is_key_pressed(KEY_SPACE):
		speed *= 2
	
	var joys = Input.get_connected_joysticks()
	if joys.size() > 0:
		var joy = joys[0]
		var axisLeftX = Input.get_joy_axis(joy, JOY_ANALOG_0_X)
		var axisLeftY = Input.get_joy_axis(joy, JOY_ANALOG_0_Y)
		dir = Vector2(axisLeftX, axisLeftY)
		if dir.length() < TRESHOLD():
			dir = Vector2(0, 0)
		if Input.is_joy_button_pressed(joy, JOY_SONY_SQUARE):
			speed *= 2
	
	move(dir * speed)
	