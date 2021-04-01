extends Flora
class_name Grass

func _ready():
  pass

var resources
var stages # Number of growth frames available
var variants # Different available textures
var variant # Which row of textures to use
var frame

var max_yield = 100
var growth_rate = 10 # Avg resources/min to increase

func init():
  Rand.calc_stats()
  # add_to_group("tickables")
  self.resources = randi() % 10
  self.stages = $Sprite.hframes
  self.variants = $Sprite.vframes
  self.variant = Rand.rangei(1, $Sprite.vframes - 1)
  check_growth()

func tick():
  check_growth()
  check_spread()

func check_growth():
  var ticks_per_min = 60 # Hardcoded for now. Ideally ticks are somewhat random
  if resources == max_yield:
    return

  var avg_resource_per_tick = (growth_rate / ticks_per_min)
  resources += Rand.bellbiasi(0, avg_resource_per_tick*2, avg_resource_per_tick, 2)
  if resources > max_yield:
    resources = max_yield
    print("Full!")

  var resources_per_stage = max_yield / (stages-1) # Max stage should be final frame
  var current_stage = int(floor(resources / resources_per_stage))
  self.frame = current_stage + (variant*(variants-1)) # Off by one, frame index vs vframe count

  if frame == $Sprite.frame:
    return

  debug()
  $Sprite.frame = frame

func debug():
  print("[resources: " + str(resources) + " | variant: " + str(variant) + " | frame: " + str(frame) + "]")

func check_spread():
  pass
