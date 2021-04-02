extends Camera2D

const MAX_ZOOM_LEVEL = 0.5
const MIN_ZOOM_LEVEL = 4.0
const ZOOM_INCREMENT = 0.05

const SLIDE_SPEED = 8
const FOLLOW_MARGIN_X = 30
const FOLLOW_MARGIN_Y = 15

var _currentZoom = 0.5
var _previousPosition: Vector2 = Vector2(0, 0)
var _isDragging: bool = false

func _unhandled_input(event):
  key_slide(event)
  drag_slide(event)
  zoom(event)

func _process(delta):
  pass
#  follow_slide()

func drag_slide(event):
  if event is InputEventMouseButton && event.button_index == BUTTON_LEFT:
    if event.is_pressed():
      _previousPosition = event.position
      _isDragging = true
    else:
      _isDragging = false

  elif event is InputEventMouseMotion && _isDragging:
    get_tree().set_input_as_handled()
    position += (_previousPosition - event.position)
    _previousPosition = event.position


func key_slide(event):
  # This isn't a very smooth slide
  var input_vector = Vector2.ZERO
  input_vector.x = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
  input_vector.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
  input_vector = input_vector.normalized()

  set_offset(get_offset() - input_vector*SLIDE_SPEED)


func follow_slide():
  var slide = Vector2(0, 0)
  var mouseVec = get_viewport().get_mouse_position()
  var viewportSize = get_viewport().size

  if mouseVec.x < 0 || mouseVec.x > viewportSize.x:
    return
  elif mouseVec.y < 0 || mouseVec.y > viewportSize.y:
    return

  if mouseVec.x < FOLLOW_MARGIN_X:
    var dist = (FOLLOW_MARGIN_X - mouseVec.x) / FOLLOW_MARGIN_X
    slide.x = dist*SLIDE_SPEED
  elif mouseVec.x > viewportSize.x - FOLLOW_MARGIN_X:
    var dist = (FOLLOW_MARGIN_X - (viewportSize.x - mouseVec.x)) / FOLLOW_MARGIN_X
    slide.x = -dist*SLIDE_SPEED

  if mouseVec.y < FOLLOW_MARGIN_Y:
    var dist = (FOLLOW_MARGIN_Y - mouseVec.y) / FOLLOW_MARGIN_Y
    slide.y = dist*SLIDE_SPEED
  elif mouseVec.y > viewportSize.y - FOLLOW_MARGIN_Y:
    var dist = (FOLLOW_MARGIN_Y - (viewportSize.y - mouseVec.y)) / FOLLOW_MARGIN_Y
    slide.y = -dist*SLIDE_SPEED

  set_offset(get_offset() - slide)


func zoom(event):
  if event is InputEventMouseButton:
    if event.is_pressed():
      # zoom in
      if event.button_index == BUTTON_WHEEL_UP:
        update_zoom(-ZOOM_INCREMENT, get_global_mouse_position())
      # zoom out
      if event.button_index == BUTTON_WHEEL_DOWN:
        update_zoom(ZOOM_INCREMENT, get_global_mouse_position())

func update_zoom(incr, zoom_anchor):
  var old_zoom = _currentZoom
  _currentZoom += incr

  if _currentZoom < MAX_ZOOM_LEVEL:
      _currentZoom = MAX_ZOOM_LEVEL
  elif _currentZoom > MIN_ZOOM_LEVEL:
      _currentZoom = MIN_ZOOM_LEVEL

  if old_zoom == _currentZoom:
      return

  var zoom_center = zoom_anchor - get_offset()
  var ratio = 1-_currentZoom/old_zoom
  set_offset(get_offset() + zoom_center*ratio)

  set_zoom(Vector2(_currentZoom, _currentZoom))
