extends Livestock
class_name Cow


# Called when the node enters the scene tree for the first time.
func _ready():
  self._idle = true
  self.speed = 8
  self.sprite_faces_right = false

func set_timer_count():
  return rand_range(1, 10)

func _on_idle_timer_timeout():
  var x = rand_range(-idle_wander_range, idle_wander_range) * 5
  var y = rand_range(-idle_wander_range, idle_wander_range) * 5

  var path_to = Vector2(global_position.x + x, global_position.y + y)

  self.path_to(path_to)

  _reset_idle_timer()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
