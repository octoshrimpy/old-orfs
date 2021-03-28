# chief

extends Entity

var vars = {}
var attributes = {}
export var active = false


# is controlled module
var is_controlled = false

func _ready():
  add_to_group("controllables")
  preload("res://Entity/run.gd").add(self)
#  Lib.oprint(what_do)
  
  self.set_sprite(sprite_states.DEFAULT)


  if can("die"):
    print("can die!")
    do("die")

  if can("run"):
    print("can run!")
    do("run")
    

##########################################
# movement by player

const ACCELERATION = 550
const MAX_SPEED = 100
const FRICTION = 550

var velocity = Vector2.ZERO


# This should be a module within entity
func _unhandled_input(event):
  if event is InputEventMouseButton and event.pressed and not event.is_echo():
    if not $Sprite.get_rect().has_point(get_local_mouse_position()):
      return
      
    if event.button_index == BUTTON_LEFT:      
      
        get_tree().set_input_as_handled() # if you don't want subsequent input callbacks to respond to this input

        # Disable all other controllables
        var controllables = get_tree().get_nodes_in_group("controllables")
        for controllable in controllables:
          controllable.is_controlled = false

        # Enable what was clicked on
        self.is_controlled = true
    elif event.button_index == BUTTON_RIGHT:
       self.switch_profession()

func _process(delta):
  if is_controlled:
    $Sprite.modulate = Color(1, 1, 1)
  else:
    $Sprite.modulate = Color(0.5, 0.5, 0.5)


    
func is_glowing(val):
  $glow.visible = val
    
    
  
##########################################  
# switch professions
enum sprite_states {
  STONED = 0,
  DEFAULT = 1,
  BABY = 2,
  CHILD = 3,
  GHOST = 5,
  MINER = 48,
  GUARD_GOLD = 36,
  GUARD_STEEL = 38,
  CARPENTER = 73,
  BLACKSMITH = 100,
  DOCTOR = 79,
  FISHERMAN = 93
}
    
func switch_profession():
  var current_state = $Sprite.frame
  var state_enum
  var next_state_index
  
  for state in sprite_states:
    if sprite_states[state] == current_state:
      state_enum = state
      print(state)
      var state_index = sprite_states.keys().find(state, 0)
      print(state_index)
      next_state_index = state_index + 1
      
      print(sprite_states.keys().size())
      if next_state_index > sprite_states.keys().size() - 1:
        next_state_index = 0
  
  self.set_sprite(sprite_states[sprite_states.keys()[next_state_index]])
          
  
  
func set_sprite(val):
  $Sprite.frame = val
