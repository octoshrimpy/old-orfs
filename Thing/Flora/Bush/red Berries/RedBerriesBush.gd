extends Bush
class_name RedBerriesBush

func _ready():
  self.variant = 5

func init():
  Rand.calc_stats()
  self.max_yield = 100
  self.resources = Rand.rangef(0, 10)
  self.growth_rate = 100
