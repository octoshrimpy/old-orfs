# chief

extends KinematicBody2D
class_name Entity

var what_do = {}

func _ready():
    pass
  
func can(action):
    if !what_do.has(action): Lib.err("action " + action + " not supported")
    return what_do.has(action)
    
func do(action):
    what_do[action].do()
