# chief

extends Entity

var vars = {}
var attributes = {}
export var active = false


# is controlled module
var is_controlled = false

func _ready():
  add_to_group("controllables")
  preload("res://scripts/base entity expansions/run.gd").add(self)
  Lib.oprint(what_do)

  if can("die"):
    print("can die!")
    do("die")

  if can("run"):
    print("can run!")
    do("run")
#
#   if can("die"):
#       print("can die!")
#       do("die")

#    Testing.can_die.init(self)
#    Testing.can_walk.init(self)
#    BaseEntity.track_hunger.init(self)
#
#func _physics_process(delta):
#    if self.attributes.is_chief:
#        BaseEntity.is_chief._physics_process(delta)



##########################################
# movement by player

const ACCELERATION = 550
const MAX_SPEED = 100
const FRICTION = 550

var velocity = Vector2.ZERO


# this should be a module within entity
func _unhandled_input(event):
  if event is InputEventMouseButton and event.pressed and not event.is_echo() and event.button_index == BUTTON_LEFT:
    if $Sprite.get_rect().has_point(get_local_mouse_position()):
      print('test')
      get_tree().set_input_as_handled() # if you don't want subsequent input callbacks to respond to this input
      
      # disable all other controllables
      var controllables = get_tree().get_nodes_in_group("controllables")
      for controllable in controllables:
        controllable.is_controlled = false
      
      #enable what was clicked on   
      self.is_controlled = true

      

func _physics_process(delta):
  
  # is controlled module
  if is_controlled:
    move_with_input(delta)

# is controlled module
func move_with_input(delta):
  var input_vector = Vector2.ZERO
  input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
  input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
  input_vector = input_vector.normalized()

  # flip sprite
  if Input.get_action_strength("ui_left"):
    $Sprite.flip_h = true
  elif Input.get_action_strength("ui_right"):
    $Sprite.flip_h = false

  if input_vector != Vector2.ZERO:
    velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
  else:
    velocity = velocity.move_toward(Vector2.ZERO, FRICTION  * delta)


  velocity = move_and_slide(velocity)
