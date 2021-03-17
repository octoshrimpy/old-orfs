extends KinematicBody2D

# base stats
var health = 100
var shield = 100
var attack = 3
var inventory_slots = 10
var lung_capacity = 10

# movement
var speed = 5
var move_loc_target # Vector3(X,Y,Z)

# basic needs
var hunger
var thirst
var tiredness


############################################
# attributes
# http://dwarffortresswiki.org/index.php/DF2014:Attribute

enum Strength {
  
}

enum Endurance {
  
}

enum Willpower {
  
}

enum Clumsiness {
  
}



############################################
# states

# this one may not be as useful, since a mob could be friendly and patrolling
#TODO: think about this later
#enum State {
#	FRIENDLY,
#	IDLE,
#	PATROL,
#	ANGRY,
#	ATTACK,
#}

enum Mood {
  HAPPY,
  CONTENT,
  NEUTRAL,
  UPSET,
  ANGRY
}

enum Hunger {
  STARVING,
  HUNGRY,
  NEUTRAL,
  SATISFIED,
  STUFFED
}

enum Wetness {
  DRY,
  WET,
  SOPPING
}

enum Energy {
  ENERGIZED,
  REFRESHED,
  NEUTRAL,
  TIRED,
  EXHAUSTED
}


############################################
# toggles

var can_shield : bool = false
var can_attack : bool = false
var can_swim : bool = false
var can_fly : bool = false
var can_walk : bool = false

var needs_food : bool = false
var needs_air : bool = false
var needs_water : bool = false



############################################
# movement

func walk_to_loc():
  pass

func swim_to_loc():
  pass

func fly_to_loc():
  # if distance is greater than x, fly, else call walk_to_loc()
  pass



############################################
# ai shenanigans

func hold_grudge():
  pass






############################################
# default funcs


func _ready():
  pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

