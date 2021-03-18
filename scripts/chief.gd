# chief

extends Entity

var vars = {}
var attributes = {}
export var active = false

func _ready():
    preload("res://scripts/run.gd").add(self)
    Lib.oprint(what_do)

    if can("die"):
      print("can die!")
      do("die")

    if can("run"):
      print("can run!")
      do("run")
#
#   if can("die"):
#       print("can die!")
#       do("die")

#    Testing.can_die.init(self)
#    Testing.can_walk.init(self)
#    BaseEntity.track_hunger.init(self)
#
#func _physics_process(delta):
#    if self.attributes.is_chief:
#        BaseEntity.is_chief._physics_process(delta)



##########################################
# movement by player

const ACCELERATION = 550
const MAX_SPEED = 100
const FRICTION = 550

var velocity = Vector2.ZERO

func _input(event):
  #  This should detect if the click is on the actual sprite. This takes graphical things. All you @octoshrimpy ;) 
  # https://www.reddit.com/r/godot/comments/7xwr22/guide_how_to_click_a_sprite
  # This has some potentials ^^
  if event is InputEventMouseButton:
    active = !active

func _physics_process(delta):
  if active:
    move_with_input(delta)

func move_with_input(delta):
  var input_vector = Vector2.ZERO
  input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
  input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
  input_vector = input_vector.normalized()

  # flip sprite
  if Input.get_action_strength("ui_left"):
    $Sprite.flip_h = true
  elif Input.get_action_strength("ui_right"):
    $Sprite.flip_h = false

  if input_vector != Vector2.ZERO:
    velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
  else:
    velocity = velocity.move_toward(Vector2.ZERO, FRICTION  * delta)


  velocity = move_and_slide(velocity)
