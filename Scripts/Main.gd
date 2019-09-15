extends Node2D


func _ready():
	$Player.connect("body_entered", self, "on_player_contact")
	$HUD/WaveControl.spawn_in_tree = $WaveManager
	update_ui_hp()
	
func _physics_process(delta):
	$HUD/EnemiesDestroyed/Number.text = str(GameState.destroyed_enemies)
	$HUD/MoneyEarned/Number.text = str(GameState.gold)
	
func update_ui_hp():
	$HUD/PlayerLife.max_value = GameState.total_hp
	$HUD/PlayerLife.value = GameState.hp
	$HUD/PlayerLife/HBoxContainer/CurrentHP.text = str(GameState.hp)
	$HUD/PlayerLife/HBoxContainer/TotalHP.text = str(GameState.total_hp)
	
	
func on_player_contact(enemy):
	enemy.emit_signal("die")
	enemy.queue_free()
	GameState.hp = max(GameState.hp - enemy.damage, 0)
	update_ui_hp()
	
