extends Node2D

var game_save = GameSave.new()

func _ready():
	GameState.update_player_stats()
	$Player.connect("body_entered", self, "on_player_contact")
	$HUD/WaveControl.spawn_in_tree = $WaveManager
	update_ui_hp()
	$HUD/SaveBtn.connect("pressed", self, "on_save_click")
	$HUD/LoadBtn.connect("pressed", self, "on_load_click")
	$Autosave.connect("timeout", self, "autosave")
	#game_save.load_game()
	
func autosave():
	game_save.save_game()
	
func on_save_click():
	game_save.save_game()
	
func on_load_click():
	game_save.load_game()
	get_tree().call_group("upgrades_ui", "update_ui")
	
func _physics_process(delta):
	$HUD/EnemiesDestroyed/Number.text = str(GameState.destroyed_enemies)
	$HUD/MoneyEarned/Number.text = str(GameState.gold)
	update_ui_hp()
	
func update_ui_hp():
	$HUD/PlayerLife.max_value = GameState.total_hp
	$HUD/PlayerLife.value = GameState.hp
	$HUD/PlayerLife/HBoxContainer/CurrentHP.text = str(GameState.hp)
	$HUD/PlayerLife/HBoxContainer/TotalHP.text = str(GameState.total_hp)
	
	
func on_player_contact(enemy):
	enemy.emit_signal("die")
	enemy.queue_free()
	var dmg = max(enemy.damage - GameState.def, 0)
	GameState.hp = max(GameState.hp - dmg, 0)
	update_ui_hp()
	
