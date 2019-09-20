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
	save_game.store_string(Marshalls.utf8_to_base64(to_json(save_data)))
	save_game.close()
	
func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://game.save"):
		return # Error! We don't have a save to load.

	save_game.open("user://game.save", File.READ)
	var save_data = parse_json(Marshalls.base64_to_utf8(save_game.get_as_text()))
	update_game(save_data)
	save_game.close()
	
func update_game(data):
	GameState.gold = data["gold"]  as int
	GameState.max_wave = data["max_wave"]  as int
	GameState.upg_proj_dmg.level = data["upg_proj_dmg"] as int
	GameState.upg_proj_speed.level = data["upg_proj_speed"]  as int
	GameState.upg_detect_radius.level = data["upg_detect_radius"]  as int
	GameState.upg_attack_delay.level = data["upg_attack_delay"]  as int
	GameState.upg_hp.level = data["upg_hp"]  as int
	GameState.upg_def.level = data["upg_def"]  as int
	GameState.update_player_stats()