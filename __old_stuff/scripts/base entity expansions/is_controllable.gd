extends Node

# is_controlled
const ACCELERATION = 550
const MAX_SPEED = 100
const FRICTION = 550

var velocity = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.




# is_controlled module

# this should be a module within entity
func _unhandled_input(event):
  if event is InputEventMouseButton and event.pressed and not event.is_echo() and event.button_index == BUTTON_LEFT:
    var position = event.position
#    if self.get_parent().get_node(self).get_rect().has_point(event.position):
    if true:
      print('test')
      get_tree().set_input_as_handled() # if you don't want subsequent input callbacks to respond to this input
      
      # disable all other controllables
      var controllables = get_tree().get_nodes_in_group("controllables")
      for controllable in controllables:
        controllable.is_controlled = false
      
      #enable what was clicked on   
      self.is_controlled = true

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
