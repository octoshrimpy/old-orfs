# chief

extends KinematicBody2D
class_name Entity

export var what_do = {}

func _ready():
  pass
  
func can(action):
  what_do.has(action)
  
func do(action):
  what_do[action].do()
