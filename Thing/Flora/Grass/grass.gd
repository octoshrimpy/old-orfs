extends Flora
class_name Grass

func _ready():
  pass

var resources
var max_yield = 100

var growth_rate = 100 # Avg +resources/min

func init():
  Rand.calc_stats()
  # add_to_group("tickables")
  self.resources = randi() % 10
  check_growth()
  print("Resources: " + str(resources))

func tick():
  check_growth()

func check_growth():
  if resources == max_yield:
    return

  resources += Rand.belli(0, 10, 3)
  if resources > max_yield:
    resources = max_yield
    print("Full!")

  var sprite_count = 4
  var mod = int(max_yield / sprite_count)
  var next_frame = int(resources / mod)

  if next_frame == $Sprite.frame:
    return

  $Sprite.frame = next_frame
