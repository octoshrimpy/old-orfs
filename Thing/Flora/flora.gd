extends Thing
class_name Flora

var stages = 0 # Number of growth frames available
var variants = 0 # Different available textures
var variant = 0 # Which row of textures to use
var frame = 0 # The current frame to show

var max_yield = 0 # Cap level of resources
var growth_rate = 0 # Avg resources/min to increase

func _ready():
  self.stages = $Sprite.hframes
  self.variants = $Sprite.vframes
  self.variant = Rand.rangei(1, $Sprite.vframes - 1)
  check_growth()

func tick():
  check_growth()
  check_spread()
  debug()

func check_growth():
  var ticks_per_min = 60 # Hardcoded for now. Ideally ticks are somewhat random
  if resources == max_yield:
    return

  var avg_resource_per_tick = (growth_rate / float(ticks_per_min))
  resources += Rand.bellbias(0, avg_resource_per_tick*3, avg_resource_per_tick, 2)
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
  Lib.debug({
   "resources": resources,
   "variant": variant,
   "frame": frame
  })

func check_spread():
  if !Rand.one_in(100):
    return

  print("Spread!")
  # Rarely, linearly likely (Small grass has low chance of spreading, tall grass has higher)
  # Find open space nearby (square touching grid?)
  #   -- open space cannot contain other grass or objects (trees/bushes)
  # spawn grass
