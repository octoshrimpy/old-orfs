# chief

extends KinematicBody2D

export var what_do = []

var vars = {}

func _ready():
	
	what_do = Entity.Eat.init(what_do)
	Entity.Die.init(self)
	what_do = Entity.Run.init(what_do)
	
	
	print(vars)
	
	if vars.can_die:
		print("can die!")
		vars.die.call_func()
