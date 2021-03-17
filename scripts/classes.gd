extends Reference

class_name Entity

############################################
# can

class can_die:
	extends Reference
	
	static func init(obj):
		obj.what_do.append("die")
		obj.vars["can_die"] = true
		obj.vars["die"] =  funcref(can_die, "do")

	static func do():
		print("am ded!")

class can_shield:
	pass
	
class can_attack:
	pass
	
class can_swim:
	pass
	
class can_fly:
	pass
	
class can_walk:
	pass


############################################
# track

class track_hunger:
	pass
	
class track_air:
	pass
	
class track_fluids: #thirst
	pass
	
class track_sleep:
	pass
	
class track_mood:
	pass



############################################
# is

class is_chief:
	extends KinematicBody2D
	
	
	static func init(obj):
		obj.attributes["is_chief"] = true
		obj.vars["die"] =  funcref(can_die, "do")
	
	
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
		
		
		velocity = self.move_and_slide(velocity)

