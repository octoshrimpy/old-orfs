extends Node2D

func _unhandled_input(event):
  if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
    var controllables = get_tree().get_nodes_in_group("controllables")
    
    for controllable in controllables:
      print(controllable.position)
      
      if controllable.is_controlled:
        var path = $Navigation2D.get_simple_path(controllable.global_position, get_global_mouse_position())
        $Line2D.points = path
        controllable.path = path
          
      
