extends Navigation2D

###########################
# from >> https://github.com/ToxicCrack/godot-tilemap-navigation
###########################

var navTileset

func _ready():
  for tilemap in get_children():
    if tilemap.is_in_group("navigation"):
      self.navTileset = tilemap
      break
  refreshNavigation()

func refreshNavigation():
  if self.navTileset:
    for tilemap in get_tree().get_nodes_in_group("tilemap"):
      if not tilemap.is_in_group("navigation"):
        Lib.oprint(tilemap.name)

        for cellIdx in tilemap.get_used_cells():
          var cell = tilemap.get_cell(cellIdx.x, cellIdx.y)

          var nav = tilemap.tile_set.tile_get_navigation_polygon(cell)
          if nav != null:
            self.navTileset.set_cell(cellIdx.x, cellIdx.y, 0)

          else:
            self.navTileset.set_cell(cellIdx.x, cellIdx.y, -1)

      tilemap.update_dirty_quadrants()
