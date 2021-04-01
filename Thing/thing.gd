extends KinematicBody2D
class_name Thing

var resources
var tick_timer

func _ready():
  start_timer()
  init()

func init():
  Lib.oprint("Unimplemented: Init called on Thing")

func tick():
  Lib.oprint("Unimplemented: Tick called on Thing")

func start_timer():
  # 1 second timer
  # TODO: This should be a global controller thing that iterates through `tickables` and calls tick
  #   on each one so we don't have thousands of these timers running.
  # OR: Every _process it selects random things to call tick on to add a degree of rand to it.
  tick_timer = Timer.new()
  self.add_child(tick_timer)

  tick_timer.connect("timeout", self, "tick")
  tick_timer.set_wait_time(1.0)
  tick_timer.set_one_shot(false) # Make sure it loops
  tick_timer.start()
