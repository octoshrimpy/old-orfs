# chief

extends Entity

var vars = {}
var attributes = {}
export var active = false


# is controlled module
var is_controlled = false
var speed = 50
var path : = PoolVector2Array()

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


# This should be a module within entity
func _unhandled_input(event):
  if event is InputEventMouseButton and event.pressed and not event.is_echo() and event.button_index == BUTTON_LEFT:
    if $Sprite.get_rect().has_point(get_local_mouse_position()):
      get_tree().set_input_as_handled() # if you don't want subsequent input callbacks to respond to this input

      # Disable all other controllables
      var controllables = get_tree().get_nodes_in_group("controllables")
      for controllable in controllables:
        controllable.is_controlled = false

      # Enable what was clicked on
      self.is_controlled = true

func _process(delta):
  if is_controlled:
    $Sprite.modulate = Color(1, 1, 1)
  else:
    $Sprite.modulate = Color(0.1, 0.1, 0.1)

  # Calculate the movement distance for this frame
  var distance_to_walk = speed * delta

  # Move the player along the path until he has run out of movement or the path ends.
  while distance_to_walk > 0 and path.size() > 0:
    var distance_to_next_point = position.distance_to(path[0])
    if distance_to_walk <= distance_to_next_point:
      position += position.direction_to(path[0]) * distance_to_walk
      if position.direction_to(path[0]).x > 0:
        $Sprite.flip_h = false
      else:
        $Sprite.flip_h = true
    else:
      # The player get to the next point
      position = path[0]
      path.remove(0)
    # Update the distance to walk
    distance_to_walk -= distance_to_next_point
