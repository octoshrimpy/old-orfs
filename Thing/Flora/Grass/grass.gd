extends Flora
class_name Grass

func _ready():
  pass

var resources
var max_yield = 100

func init():
  # add_to_group("tickables")
  self.resources = randi() % 10
  check_growth()
  print("Resources: " + str(resources))

func tick():
  if resources == max_yield:
    return
  if (randi() % 2) == 1:
    return

  resources += (randi() % 5) + 5
  if resources > max_yield:
    resources = max_yield
    print("Full!")

  check_growth()

func check_growth():
  var sprite_count = 4
  var mod = int(max_yield / sprite_count)
  var next_frame = sprite_count - 1 - int(resources / mod)

  if next_frame == $Sprite.frame:
    return

  $Sprite.frame = next_frame
