extends Thing
class_name Flora

var stages = 0 # Number of growth frames available
var variants = 0 # Different available textures
var variant = 0 # Which row of textures to use
var frame = 0 # The current frame to show

var max_yield = 0 # Cap level of resources
var growth_rate = 0 # Avg resources/min to increase

func _ready():
  add_to_group("tickables")
  self.stages = $Sprite.hframes
  self.variants = $Sprite.vframes
  self.variant = Rand.rangei(1, $Sprite.vframes - 1)
  check_growth()

func tick():
  check_growth()
  check_spread()

func check_growth():
  if growth_rate == 0:
    return
  if resources == max_yield:
    return

  # debug()
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

  $Sprite.frame = frame

func debug():
  Lib.debug({
   "resources": resources,
   "variant": variant,
   "frame": frame
  })

func check_spread():
  spread() # Temp while testing spread mechanics

  # TODO: Hardcoding this. Figure out how to extract it into an option later
  var chance = 100 - int((resources / 10) * 5)
  # resources[1] = 1/100 chance to spread each tick
  # resources[100] = 1/50 chance to spread each tick
  if Rand.one_in(chance):
    spread()

func spread():
  print("Spread!")
  var cell_size = $Sprite.texture.get_size()
  var spread_min_distance = 1 # Min number of cells away to spread
  var spread_max_distance = 1 # Max number of cells away to spread
  var multiplier_arr = [-1, 1]
  multiplier_arr.shuffle()
  var x_offset = Rand.rangei(spread_min_distance, spread_max_distance) * multiplier_arr.front()
  multiplier_arr.shuffle()
  var y_offset = Rand.rangei(spread_min_distance, spread_max_distance) * multiplier_arr.front()
  var distance = Vector2(x_offset * cell_size.x, y_offset * cell_size.y)
  var spawn_location = get_position() + distance

  # TODO: Verify the space is open
  #   -- open space cannot contain other grass or objects (trees/bushes)
  # TODO: Spawn new object at `spawn_location`
  print(spawn_location)
  # MAYBE: Instead get all possible locations of spread, remove the taken spaces, the select randomly.
  # - Pros: More realistic spread (more grass means more likely to spread)
  # - Cons: Could be expensive if something can spread over a large area (tree saplings may be carried by wind a great distance?)
