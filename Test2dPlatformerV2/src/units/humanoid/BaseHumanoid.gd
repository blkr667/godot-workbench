extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
var ACCELERATION = 10
const MAX_FALL_SPEED = 400
var MAX_SPEED = 250
const JUMP_FORCE = 300
var ATTACK_POWER = 9
var BUILDING_ATTACK_POWER = 3

export(Global.FACTION) var faction

var state = Global.HUMANOID_STATE.IDLE
var rng = RandomNumberGenerator.new()


var motion = Vector2()
var dying = false
var attacking = false
var hp = 40

export(Global.WIDTH) var width = Global.WIDTH.STANDARD
export(Global.HEIGHT) var height = Global.HEIGHT.MEDIUM


func _ready():
	if height == Global.HEIGHT.TALL:
		$Sprite.scale.y = $Sprite.scale.y * 1.3
		$CollisionShape2D.shape.set_height(6.0)
		
	if height == Global.HEIGHT.SHORT:
		$Sprite.scale.y = $Sprite.scale.y * 0.7
		$CollisionShape2D.shape.set_height(2.0)
		
	if width == Global.WIDTH.FAT:
		$Sprite.scale.x = $Sprite.scale.x * 1.2
		$CollisionShape2D.shape.set_radius(7.0)
		$CollisionShape2D.shape.set_height(2.0)
		
	if width == Global.WIDTH.THIN:
		print($Sprite.scale.x)
		$Sprite.scale.x = $Sprite.scale.x * 0.8
		$CollisionShape2D.shape.set_radius(3.0)
		$CollisionShape2D.shape.set_height(6.0)
		print($Sprite.scale.x)

		
	
		
	if faction == Global.FACTION.RED:
		modulate = Color(rng.randf_range(0.1, 0.5), 0, 0);
	elif faction == Global.FACTION.BLUE:
		modulate = Color(0, 0, rng.randf_range(0.1, 0.5));
	else:
		faction = Global.FACTION.NEUTRAL

func _physics_process(delta):
	
	
	if !attacking && !dying:
		if state == Global.HUMANOID_STATE.IDLE:
			$AnimationPlayer.play("Idle")
			
		if state == Global.HUMANOID_STATE.MOVING_RIGHT:
			$AnimationPlayer.play("Run")
			motion.x += ACCELERATION
			$Sprite.scale.x = 1;
			
		if state == Global.HUMANOID_STATE.MOVING_LEFT:
			$AnimationPlayer.play("Run")
			motion.x -= ACCELERATION
			$Sprite.scale.x = -1;

		
	if motion.y > MAX_FALL_SPEED:
		motion.y = MAX_FALL_SPEED
		
		
		
	if !dying && hp <= 0:
		dying = true
		$AnimationPlayer.play("Death")
		set_collision_layer_bit(2, true)
		set_collision_layer_bit(1, false)
		set_collision_mask_bit(3, false)
		set_collision_mask_bit(4, false)
		
		
		
	
	motion.y += GRAVITY
	if motion.y > MAX_FALL_SPEED:
		motion.y = MAX_FALL_SPEED
	motion.x = lerp(motion.x, 0, 0.2)
	motion = move_and_slide(motion, UP)


func die():
	self.queue_free()
	
func attack_end():
	attacking = false
	
func resolve_attack(body):
	# TODO: w global musza byc relacje miedy frakcjami
	if !dying && body.get("faction") != null && Global.is_hostile(faction, body.faction):
		attacking = true
		
		if body.get_class() == "StaticBody2D":
			body.hp -= BUILDING_ATTACK_POWER
		$AnimationPlayer.play("Attack")
		var weapon_direction: Vector2 = (body.global_position - global_position).normalized()
		$Weapon.rotation = weapon_direction.angle()
		$Weapon.attack()
		
func resolve_hit(body):
	if body.get("faction") != null && faction != body.faction:
		body.hp = body.hp - ATTACK_POWER
		var enemy_detector: Area2D = $EnemyDetector

