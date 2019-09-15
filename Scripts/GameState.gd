extends Node

var destroyed_enemies = 0
var gold = 10000
var max_wave = 1
var current_wave = 1
var hp = 100
var total_hp = 100
var player_proj_dmg = 5
var player_proj_speed = 500
var player_radius = 200
var player_attack_delay = 1
var enemy_base_hp = 5
var enemy_base_damage = 1
var enemy_base_speed = 50
var wave_base_density = 10

var upg_proj_dmg = Upgrade.new("Projectile damage", 5, 10, 1)
var upg_proj_speed = Upgrade.new("Projectile speed", 400, 10, 1)
var upg_detect_radius = Upgrade.new("Detection radius", 200, 10, 1)
var upg_attack_delay = Upgrade.new("Attack delay", 1, 15, -0.1)

func get_wave_hp(wave):
	return floor(enemy_base_hp * pow(1.10, wave))
	
func get_wave_damage(wave):
	return floor(enemy_base_damage * pow(1.10, wave))
	
func get_wave_density(wave):
	return wave_base_density + floor(wave/10)

func update_player_stats():
	player_proj_dmg = upg_proj_dmg.get_current_total_value()
	player_proj_speed = upg_proj_speed.get_current_total_value()
	player_radius = upg_detect_radius.get_current_total_value()
	player_attack_delay = upg_attack_delay.get_current_total_value()
