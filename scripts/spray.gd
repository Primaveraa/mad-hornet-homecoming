extends StaticBody2D

var velocity = 200
var timer = 1
var can_shoot = true
var gasTemplate = null

func _ready():
	self.set_fixed_process(true)
	gasTemplate = preload("res://scenes/gas.tscn")
	
func _fixed_process(delta):
	var pos = get_pos()
	pos += Vector2(-velocity * delta, 0)
	set_pos(pos)
	var parent = get_parent()
	var pos_par = parent.get_pos()
	var pos_world = pos + pos_par
	if pos_world.x < -100:
		parent.remove_child(self)
		
	if timer<=0 and can_shoot:
		can_shoot = false
		var spawn = get_parent()
		var gas = gasTemplate.instance()
		var pos = get_pos()
		gas.set_pos(Vector2(-19,-50)+pos)
		gas.set_scale(Vector2(0.3, 0.3))
		gas.velocity = velocity * 2
		spawn.add_child(gas)
	else:
		timer -= delta