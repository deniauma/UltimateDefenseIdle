extends Node

var destroyed_enemies = 0
var gold = 10000
var base_gold_per_kill = 1
var max_wave = 1
var current_wave = 1
var hp = 1
var def = 0
var total_hp = 1
var player_proj_dmg = 5
var player_proj_speed = 500
var player_radius = 200
var player_proj_aoe_radius = 15
var player_attack_delay: float = 1.0
var enemy_base_hp = 5
var enemy_base_damage = 1
var enemy_base_speed = 50
var wave_base_density = 10
var wave_base_spawn_rate = 1.0

#Attack upgrades
var upg_proj_dmg = Upgrade.new("Projectile damage", 5, 10, 1)
var upg_proj_speed = Upgrade.new("Projectile speed", 400, 10, 1)
var upg_detect_radius = Upgrade.new("Detection radius", 200, 10, 1)
var upg_attack_delay = Upgrade.new("Attack delay", 1.0, 15, -0.01)

#Defense upgrades
var upg_hp = Upgrade.new("Tower HP", 1, 10, 1)
var upg_def = Upgrade.new("Damage reduction", 0, 20, 1, 1.20)

func get_wave_hp(wave):
	return floor(enemy_base_hp * pow(1.05, wave))
	
func get_wave_damage(wave):
	return floor(enemy_base_damage * pow(1.05, wave))

func get_wave_speed(wave):
	return floor(enemy_base_speed + 1.05*floor(wave/10))
	
func get_wave_density(wave):
	return wave_base_density + floor(wave/10)
	
func get_wave_spawn_rate(wave):
	return wave_base_spawn_rate - 0.05*floor(wave/10)
	
func get_gold_per_kill(wave):
	return floor(base_gold_per_kill * pow(1.05, wave))

func update_player_stats():
	player_proj_dmg = upg_proj_dmg.get_current_total_value()
	player_proj_speed = upg_proj_speed.get_current_total_value()
	player_radius = upg_detect_radius.get_current_total_value()
	player_attack_delay = upg_attack_delay.get_current_total_value()
	total_hp = upg_hp.get_current_total_value()
	def = upg_def.get_current_total_value()
