extends Livestock
class_name Cow


# Called when the node enters the scene tree for the first time.
func _ready():
  self._idle = true
  self.speed = 8
  self.sprite_faces_right = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass

    
