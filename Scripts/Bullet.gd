extends KinematicBody2D

var damage = GameState.player_proj_dmg
var speed = GameState.player_proj_speed
var aoe_radius = GameState.player_proj_aoe_radius
var target = Vector2()
var velocity = Vector2()

func _ready():
	$HitBox.connect("body_entered", self, "on_hit")
	$TTL.connect("timeout", self, "self_destroy")
	set_aoe_radius(aoe_radius)
	pass

func set_aoe_radius(radius):
	$AoE/CollisionShape2D.shape.radius = radius

func _physics_process(delta):
	if velocity.x == 0 and velocity.y == 0:
		velocity = (target - global_position).normalized() * speed
	rotation = Vector2(0, -1).angle_to(velocity)
	if (target - global_position).length() > 1:
		velocity = move_and_slide(velocity)
	else:
		self_destroy()


func on_hit(body: Enemy):
	var enemies_hit = $AoE.get_overlapping_bodies()
	if not enemies_hit.empty():
		for enemy in $AoE.get_overlapping_bodies():
			enemy.take_damage(damage)
	else:
		body.take_damage(damage)
	queue_free()
	
func self_destroy():
	queue_free()
