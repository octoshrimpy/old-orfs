extends Reference

class_name Entity

class Die:
  extends Reference
  
  static func init(obj):
    obj.what_do.append("die")
    obj.vars["can_die"] = true
    obj.vars["die"] =  funcref(Die, "do")

  static func do():
    print("am ded!")

