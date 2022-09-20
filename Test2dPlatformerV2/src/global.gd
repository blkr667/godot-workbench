extends Node


enum FACTION{RED, BLUE, GREEN, NEUTRAL, MONSTER, RECRUIT}

enum HUMANOID_STATE{ ## chyba najlepiej wszystko na bool flagi
	IDLE, 
	MOVING_LEFT, 
	MOVING_RIGHT, 
	JUMPING, # skoki oddzielnie bo moga byc podczas poruszania sie 
	FALLING,
	DIE,
	ATTACK
}

enum HEIGHT {
	SHORT,
	MEDIUM,
	TALL
}

enum WIDTH {
	THIN,
	STANDARD,
	FAT
}

enum HUMANOID_ORDER {
	GUARD, 
	MOVE_LEFT, 
	MOVE_RIGHT, 
	JUMP
}

func _ready():
	print("global ready")

var abc = "123"

func hello() -> void:
	print("hello")
	
func is_hostile(faction1, faction2):
	var factions = [faction1, faction2]
	if factions.has(FACTION.RED) && factions.has(FACTION.BLUE):
		return true
	return false

