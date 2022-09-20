extends StaticBody2D

var global = preload("res://src/global.gd")

var rng = RandomNumberGenerator.new()
export var right = true
var nextSpawnTime = 1.0
const HUMANOID_LIMIT = 10;

func _ready():
	$Timer.start(nextSpawnTime)


func _on_Timer_timeout():
	var scene = Engine.get_main_loop().current_scene
	rng.randomize()
	var humanoidPreload = preload("res://tscn/RecruitHumanoid.tscn")
	var humanoid = humanoidPreload.instance()
	humanoid.position.x = position.x
	humanoid.position.y = position.y - 20
	if right:
		humanoid.set_order(global.HUMANOID_ORDER.MOVE_RIGHT)
	else:
		humanoid.set_order(global.HUMANOID_ORDER.MOVE_LEFT	)
			
	scene.add_child(humanoid)
	$Timer.start(rng.randf_range(1, 5))
