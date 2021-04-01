extends Flora
class_name Grass

func _ready():
  pass

func init():
  # Rand.calc_stats()
  # add_to_group("tickables")
  self.max_yield = 100
  self.growth_rate = 10
  self.resources = Rand.rangef(0, 10)
