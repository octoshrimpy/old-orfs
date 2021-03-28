
extends KinematicBody2D
class_name Entity

var what_do = {}



func _ready():
    pass
  
func can(action):
    if !what_do.has(action): print("action " + action + " not supported")
    return what_do.has(action)
    
func do(action):
    what_do[action].do()
