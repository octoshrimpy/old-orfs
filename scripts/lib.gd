extends Reference
class_name Lib

static func oprint(msg):
    print("[ -O- ] ", msg)

static func err(thing):
    print("[ ERR ] ", thing)

static func debug(obj):
  var obj_str = "["
  var obj_arr = Array()
  for key in obj.keys():
    obj_arr.push_back(str(key) + ": " + str(obj[key]))
  print("[ " + PoolStringArray(obj_arr).join(" | ") + " ]")
