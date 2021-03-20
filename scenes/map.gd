extends Node2D

func _unhandled_input(event):
  if event is InputEventMouseButton:
    if event.button_index == BUTTON_LEFT and event.pressed:
      var controllables = get_tree().get_nodes_in_group("controllables")
      for controllable in controllables:
        print(controllable.position)
        if controllable.is_controlled:
          var path = $Navigation2D.get_simple_path(controllable.position, event.position)
          $Navigation2D/Line2D.points = path
          controllable.path = path
          
      
