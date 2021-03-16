# chief

extends KinematicBody2D

export var what_do = []

var can_die = false
var die

func _ready():
	
	what_do = Entity.Eat.init(what_do)
	
	Entity.Die.init(self)
	
	what_do = Entity.Run.init(what_do)
	
	print(can_die)
	
	self.die.call_func()
