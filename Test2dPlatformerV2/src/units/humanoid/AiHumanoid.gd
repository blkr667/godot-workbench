
extends "res://src/units/humanoid/BaseHumanoid.gd"

var MAX_TICK = 200
var tick = 0


export(String) var orderInput = "";
var order = Global.HUMANOID_ORDER.MOVE_RIGHT

func _ready():
	ACCELERATION = 30
	if orderInput != "":
		set_order(Global.HUMANOID_ORDER.get(orderInput))

func _physics_process(delta):
	if is_on_floor() and order == Global.HUMANOID_ORDER.JUMP:
		motion.y = -JUMP_FORCE
	elif order == Global.HUMANOID_ORDER.MOVE_RIGHT:
		state = Global.HUMANOID_STATE.MOVING_RIGHT
	elif order == Global.HUMANOID_ORDER.MOVE_LEFT:
		state = Global.HUMANOID_STATE.MOVING_LEFT
	else:
		state = Global.HUMANOID_STATE.IDLE
		
	tick += 1
	if tick > MAX_TICK:
		tick = 0
		
		
func set_order(new_order):
	if (order == Global.HUMANOID_ORDER.MOVE_LEFT and new_order == Global.HUMANOID_ORDER.MOVE_RIGHT) or (order == Global.HUMANOID_ORDER.MOVE_RIGHT and new_order == Global.HUMANOID_ORDER.MOVE_LEFT):
		if $AttackDetector != null:
			$AttackDetector.scale.x = -$AttackDetector.scale.x
			$EnemyDetector.scale.x = -$EnemyDetector.scale.x

	order = new_order

		
