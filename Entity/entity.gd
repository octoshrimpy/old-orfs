
extends KinematicBody2D
class_name Entity

var what_do = {}

var sprite_faces_right = true
var speed = 150
var path : = PoolVector2Array()

var idle_wander_range = 7

var _idle = false
var _idle_timer = null

onready var _map = get_tree().get_current_scene().get_node("map")
onready var _nav = _map.get_node("Navigation2D")
onready var _line = _map.get_node("Line2D")

func _ready():
  pass
  # print(_nav)
  # print(_line)

func can(action):
    if !what_do.has(action): print("action " + action + " not supported")
    return what_do.has(action)

func do(action):
    what_do[action].do()


#################################################
# begin private Entity functions
#################################################

func _process(delta):
  _do_pathing(delta)
  _idle(delta)


# called every _process
func _do_pathing(delta):
  #drop out early
  if not path.size() > 0:
    return

  # Calculate the movement distance for this frame
  var distance_to_walk = speed * delta

  # Move the entity along the path until he has run out of movement or the path ends.
  while distance_to_walk > 0 and path.size() > 0:
    var distance_to_next_point = position.distance_to(path[0])
    if distance_to_walk <= distance_to_next_point:
      position += position.direction_to(path[0]) * distance_to_walk
      if position.direction_to(path[0]).x > 0:
        $Sprite.flip_h = !sprite_faces_right
      else:
        $Sprite.flip_h = sprite_faces_right
    else:
      # The entity get to the next point
      position = path[0]
      path.remove(0)
    # Update the distance to walk
    distance_to_walk -= distance_to_next_point


func _idle(delta):
  if not _idle == true:
    return
  if _idle_timer == null:
    _reset_idle_timer()


func _reset_idle_timer():
  randomize()

  if _idle_timer == null:
    _idle_timer = Timer.new()
    add_child(_idle_timer)

  # BUG timer isn't changing time, and wandering around is same time between calls
  _idle_timer.connect("timeout", self, "_on_idle_timer_timeout")
  var timer_count = set_timer_count()
  _idle_timer.set_wait_time(timer_count)
  _idle_timer.set_one_shot(false)
  _idle_timer.start()

func set_timer_count():
  Lib.err("Not implemented - this function should be defined on the instance.")

func _on_idle_timer_timeout():
  Lib.err("Not implemented - this function should be defined on the instance.")


#################################################
# begin public Entity functions
#################################################

func path_to(path_to):
  path = self._nav.get_simple_path(global_position, path_to)

  # this is for DEBUG purposes only
  self._line.points = path

  self.path = path
