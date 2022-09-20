extends StaticBody2D

var global = preload("res://src/global.gd")

var rng = RandomNumberGenerator.new()
export var right = true

export (String) var factionInput = "";
var faction = global.FACTION.NEUTRAL;


var nextSpawnTime = 1.0
const HUMANOID_LIMIT = 30;

var recruitCounter = 0

var hp = 20

func _ready():
	$Timer.start(nextSpawnTime)
	if factionInput != "":
		faction = global.FACTION.get(factionInput)

func _physics_process(delta):
	$Label.text = str(recruitCounter)
	if hp <= 0:
		self.queue_free()

func _on_Area2D_body_entered(body):
	if body.get("faction") != null :
		if body.faction == global.FACTION.RECRUIT:
			body.queue_free()
			recruitCounter += 1
		# elif body.faction != faction && body.get("resolve_attack") != null:
		elif body.faction != faction:
			body.resolve_attack(self)
			

func _on_Timer_timeout():
	
	if recruitCounter > 0:
		var scene = Engine.get_main_loop().current_scene
		var producedUnitCount = 0
		for i in scene.get_children():
			if i.get("faction") != null && i.faction == faction:
				producedUnitCount = producedUnitCount + 1
				
		rng.randomize()
		if producedUnitCount < HUMANOID_LIMIT:
			var humanoidPreload = preload("res://tscn/WarriorHumanoid.tscn")
			var humanoid = humanoidPreload.instance()
			humanoid.position.x = position.x
			humanoid.position.y = position.y - 20
			humanoid.faction = faction

			if right:
				humanoid.set_order(global.HUMANOID_ORDER.MOVE_RIGHT)
				#humanoid.order = global.HUMANOID_ORDER.MOVE_RIGHT;
			else:
				humanoid.set_order(global.HUMANOID_ORDER.MOVE_LEFT)
				#humanoid.order = global.HUMANOID_ORDER.MOVE_LEFT;
				
			scene.add_child(humanoid)
			recruitCounter -= 1
	$Timer.start(rng.randf_range(1, 5))
