extends Node

class_name GameSave

func save():
	var save_data = {
		"gold": GameState.gold,
		"max_wave": GameState.max_wave,
		"upg_proj_dmg": GameState.upg_proj_dmg.level,
		"upg_proj_speed": GameState.upg_proj_speed.level,
		"upg_detect_radius": GameState.upg_detect_radius.level,
		"upg_attack_delay": GameState.upg_attack_delay.level,
		"upg_hp": GameState.upg_hp.level,
		"upg_def": GameState.upg_def.level
	}
	print(save_data)
	return save_data
	
func save_game():
	var save_game = File.new()
	save_game.open("user://game.save", File.WRITE)
	var save_data = save()
	save_game.store_line(to_json(save_data))
	save_game.close()
	
