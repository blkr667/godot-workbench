extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const ATTACK_POWER = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func attack():
	get_node("WeaponAnimationPlayer").play("Attack");

func _on_Area2D_body_entered(body):
	if get_parent() != body and body.get("hp") != null:
		body.hp = body.hp - ATTACK_POWER

func attack_started():
	get_node("Node2D/Sprite/Area2D").monitoring = true
	
func attack_finished():
	get_node("Node2D/Sprite/Area2D").monitoring = false
