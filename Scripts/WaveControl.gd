extends VBoxContainer

signal wave_cleared
signal wave_failed

const spawned_enemy = preload("res://Scenes/Enemy.tscn")

var wave_hp = GameState.enemy_base_hp
var wave_damage = 1
var wave_size = 5
var wave_remaining = 10
var spawned = 0
var farming = false
var spawn_in_tree: Node2D

onready var next_btn = $WaveNav/Next
onready var prev_btn = $WaveNav/Prev
onready var farming_toggle = $HBoxContainer2/FarmingMode
onready var wave_progress = $HBoxContainer/WaveProgress
onready var spawner = $SpawnTrigger
var player

func _ready():
	next_btn.connect("pressed", self, "on_next_wave_click")
	prev_btn.connect("pressed", self, "on_prev_wave_click")
	farming_toggle.connect("toggled", self, "on_farming_mode_click")
	spawner.connect("timeout", self, "spawn")
	prepare_wave(GameState.max_wave)
	
func prepare_wave(level):
	get_tree().call_group("enemies", "queue_free")
	wave_hp = GameState.get_wave_hp(level)
	wave_damage = GameState.get_wave_damage(level)
	wave_size = GameState.get_wave_density(level)
	GameState.current_wave = level
	wave_progress.max_value = wave_size
	wave_progress.value = 0
	$WaveNav/WaveLvl.text = "Wave " + str(level)
	player = get_tree().get_nodes_in_group("player")[0]
	wave_remaining = wave_size
	spawned = 0
	farming_toggle.pressed = false
	spawner.start()
	
func spawn():
	var enemy = spawned_enemy.instance()
	enemy.connect("die", self, "on_enemy_die")
	enemy.position.x = player.position.x + 400*cos(rand_range(0, 360))
	enemy.position.y = player.position.y + 400*sin(rand_range(0, 360))
	enemy.target = player.position
	enemy.hp = wave_hp
	enemy.damage = wave_damage
	spawn_in_tree.add_child(enemy) #get_tree().get_root().add_child(enemy)
	spawned += 1
	if spawned >= wave_size and not farming:
		spawner.stop()
	
func on_enemy_die():
	wave_remaining = max(0, wave_remaining - 1)
	
func _physics_process(delta):
	wave_progress.value = wave_size - wave_remaining
	if GameState.current_wave < GameState.max_wave or wave_remaining == 0:
		next_btn.disabled = false
		if not farming:
			on_next_wave_click()
	else:
		next_btn.disabled = true
	prev_btn.disabled = (GameState.current_wave == 1)
	
func on_next_wave_click():
	GameState.current_wave += 1
	GameState.max_wave = max(GameState.current_wave, GameState.max_wave)
	prepare_wave(GameState.current_wave)
	
func on_prev_wave_click():
	GameState.current_wave -= 1
	prepare_wave(GameState.current_wave)
	
func on_farming_mode_click(toggled):
	farming = toggled
	
	