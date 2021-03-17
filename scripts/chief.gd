# chief

extends Entity

var vars = {}

var attributes = {}

func _ready():
  preload("res://scripts/run.gd").add(self)
  
  print(what_do)
  print(can("run"))
  
  if can("die"):
    print("can die!")
    do("die")
    
  if can("run"):
    print("can run!")
    do("run")
    
    Testing.can_die.init(self)
    Testing.can_walk.init(self)





##########################################
# movement by player

const ACCELERATION = 550
const MAX_SPEED = 100
const FRICTION = 550

var velocity = Vector2.ZERO

func _physics_process(delta):
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
    print(velocity)
  else:
    velocity = velocity.move_toward(Vector2.ZERO, FRICTION  * delta)
  
  
  velocity = move_and_slide(velocity)
