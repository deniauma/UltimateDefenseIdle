extends Area2D

const bullet = preload("res://Scenes/Bullet.tscn")

onready var detect_circle = $DetectCircle

func _ready():
	add_to_group("player")
	$AttackDelay.connect("timeout", self, "attack_enemy")
	
func _physics_process(delta):
	$AreaDetection/AreaRadius.shape.radius = GameState.player_radius
	detect_circle.radius = GameState.player_radius
	detect_circle.update()
	$AttackDelay.wait_time = GameState.player_attack_delay
	
func attack_enemy():
	var target = choose_target()
	if target != null:
		var new_bullet = bullet.instance()
		new_bullet.target = target.global_position
		call_deferred("add_child", new_bullet)
		var target_dir = (target.global_position - global_position).normalized()
		$Tower/Turret.rotation = Vector2(0, -1).angle_to(target_dir)
#	var shoot = false
#	while not shoot and not detected_enemies.empty():
#		var target = get_tree().get_root().get_node_or_null(detected_enemies.pop_front())
#		if target != null:
#			var new_bullet = bullet.instance()
#			new_bullet.target = target.global_position
#			call_deferred("add_child", new_bullet)
#			shoot = true

func choose_target():
	var min_dist = -1
	var selected_enemy = null
	for enemy in $AreaDetection.get_overlapping_bodies():  #get_tree().get_nodes_in_group("enemies"):
		var d = enemy.global_position.distance_to(self.global_position)
		if min_dist == -1 or d < min_dist:
			selected_enemy = enemy
			min_dist = d
	return selected_enemy
		
