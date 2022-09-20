
# extends KinematicBody2D
extends "res://src/units/humanoid/BaseHumanoid.gd"

onready var weapon: Node2D = get_node("Weapon")

func _ready():
	ACCELERATION = 50

func _physics_process(delta):
	
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	if Input.is_action_pressed("RIGHT"):
		state = Global.HUMANOID_STATE.MOVING_RIGHT
	elif Input.is_action_pressed("LEFT"):
		state = Global.HUMANOID_STATE.MOVING_LEFT
	else:
		state = Global.HUMANOID_STATE.IDLE
		
	if Input.is_action_pressed("ATTACK"):
		#print(global.get("hello"))
		Global.hello()

		#state = global.HUMANOID_STATE.ATTACK
		$Weapon.attack();
		
	if is_on_floor() and Input.is_action_pressed("JUMP"):
		motion.y = -JUMP_FORCE
		
	weapon.rotation = mouse_direction.angle()
		

		
