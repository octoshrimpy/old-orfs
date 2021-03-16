extends Reference

class_name Entity
class Run:
	extends Reference
	
	var do = funcref(self, "do")
	
	static func init(what_do):
		what_do.append("run")
		
		
		return what_do
		
	static func do():
		return "am running!"


class Eat:
	extends Reference
	
	var dovar = funcref(self, "do")
	
	static func init(what_do):
		what_do.append("eat")
		return what_do
		
	static func do():
		return "am eating!"


class Die:
	extends Reference
	
	
	static func init(obj):
		obj.what_do.append("die")
		obj.vars["can_die"] = true
		obj.vars["die"] =  funcref(Die, "do")
		
	static func do():
		print("am ded!")
		
