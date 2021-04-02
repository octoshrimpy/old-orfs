extends Flora
class_name Bush

func _ready():
  pass

func init():
  Rand.calc_stats()
  self.max_yield = 100
  self.resources = Rand.rangef(0, 10)
  self.growth_rate = 100
