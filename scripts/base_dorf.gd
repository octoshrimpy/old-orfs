extends Entity

onready var sprite = get_node("Sprite")

enum sprite_states {
  STONED = 0,
  DEFAULT = 1,
  BABY = 2,
  CHILD = 3,
  GHOST = 5,
  MINER = 48,
  GUARD_GOLD = 36,
  GUARD_STEEL = 38,
  CARPENTER = 73,
  BLACKSMITH = 100,
  DOCTOR = 79,
  FISHERMAN = 93
}

func _ready():
  set_sprite(sprite_states.GUARD_GOLD)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass



func set_sprite(sprite_enum):
  sprite.frame = sprite_enum
  
