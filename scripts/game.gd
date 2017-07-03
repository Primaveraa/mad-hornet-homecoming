extends Node2D

static func GAME_ACCELERATION():
	return 0.1
	
static func SEICENTOS_TIMEOUT():
	return 3

static func SPREYS_TIMEOUT():
	return 2

var gameSpeed = 1
var seicentoTemplate = null
var seicentosTimer = 0
var spreyTemplate = null
var spreyTimer = 0
var timer = 0

func _ready():
	set_fixed_process(true)
	randomize()
	seicentoTemplate = preload("res://scenes/seicento.tscn")
	spreyTemplate = preload("res://scenes/spray.tscn")
	
func _fixed_process(delta):
	gameSpeed += GAME_ACCELERATION() * delta
	timer += delta
	var label = get_node("ui/timer")
	var timeStr = str(int(ceil(timer)))
	label.set_text("Your time: " + timeStr)
	
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	var joys = Input.get_connected_joysticks()
	if joys.size() > 0:
		var joy = joys[0]
		if Input.is_joy_button_pressed(joy, JOY_SONY_CIRCLE):
			get_tree().quit()
	
	var hornet = get_node("world/hornet")
	hornet.velocity = gameSpeed * 450
	
	if seicentosTimer <= 0:
		seicentosTimer = SEICENTOS_TIMEOUT()
		var spawn = get_node("world/enemies/seicentos")
		var seicento = seicentoTemplate.instance()
		var random = (randf()-0.5)*200
		seicento.set_pos(Vector2(0, random))
		seicento.set_scale(Vector2(0.3, 0.3))
		seicento.velocity = gameSpeed * 300
		spawn.add_child(seicento)
	else:
		seicentosTimer -= gameSpeed * delta
		
	if spreyTimer <= 0:
		spreyTimer = SPREYS_TIMEOUT()
		var spawn = get_node("world/enemies/sprays")
		var sprey = spreyTemplate.instance()
		var random = (randf()-0.5)*300
		var random_rot = deg2rad((randf()-0.5) * 60) 
		sprey.set_pos(Vector2(0, random))
		sprey.set_scale(Vector2(0.5, 0.5))
		sprey.set_rot(random_rot)
		sprey.velocity = gameSpeed * 350
		sprey.timer = 1/gameSpeed
		spawn.add_child(sprey)
	else:
		spreyTimer -= gameSpeed * delta
	