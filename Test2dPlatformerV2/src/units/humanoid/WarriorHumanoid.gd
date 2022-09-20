
extends "res://src/units/humanoid/AiHumanoid.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var counter = 0;
var jump_count = 400
var HIT_COOLDOWN = 2.0
# Called when the node enters the scene tree for the first time.
func _ready():
	MAX_SPEED = 150


func _physics_process(delta):
	$Label.text = str(hp)
	counter +=1;
	
			
	if tick == MAX_TICK:
		if !attacking && !dying:
			if abs(motion.x) < 10:
				
				if order == Global.HUMANOID_ORDER.MOVE_LEFT && position.x < get_tree().get_root().get_node("World").get_node("BarracksRed").position.x:
					set_order(Global.HUMANOID_ORDER.MOVE_RIGHT)
				elif order == Global.HUMANOID_ORDER.MOVE_RIGHT && position.x > get_tree().get_root().get_node("World").get_node("BarracksBlue").position.x:
					set_order(Global.HUMANOID_ORDER.MOVE_LEFT)
				else:
					motion.y = -JUMP_FORCE
			
			
			
		# Zawróć jeśli biegniesz w lewo, masz brak predkosci, a wszystkie cele sa po prawej
			
			

func _on_EnemyDetector_body_entered(body):
	resolve_attack(body)

func _on_AttackDetector_body_entered(body):
	resolve_hit(body)

func hit_start():
	$AttackDetector.monitoring = true
	
func hit_end():
	$AttackDetector.monitoring = false
	
	$EnemyDetector.monitoring = false
	yield(get_tree().create_timer(HIT_COOLDOWN), "timeout")
	$EnemyDetector.monitoring = true
