extends "res://src/units/humanoid/AiHumanoid.gd"

func _ready():
	ACCELERATION = 10
	hp = 8
	modulate = Color(5.0, 5.0, 5.0);
	faction = Global.FACTION.RECRUIT
