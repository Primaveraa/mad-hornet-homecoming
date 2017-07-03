extends StaticBody2D

var velocity = 100

func _ready():
	self.set_fixed_process(true)
	
func _fixed_process(delta):
	var pos = get_pos()
	pos += Vector2(-velocity * delta, 0)
	set_pos(pos)
	var parent = get_parent()
	var pos_par = parent.get_pos()
	var pos_world = pos + pos_par
	if pos_world.x < -100:
		parent.remove_child(self)
