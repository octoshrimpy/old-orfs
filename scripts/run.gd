static func add(obj):
  print("Added")
  obj.what_do["run"] = Run.new(obj)

class Run:
  func _init(obj):
    var a = obj
    
  func do():
    print("Doing run")
