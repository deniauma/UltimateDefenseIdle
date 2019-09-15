extends Control

func _ready():
	$UpgradesBar/upgradesBtn.connect("pressed", self, "on_upgrades_click")
	$PopupPanel/TabContainer/Attack/ProjDmg.set_upgrade(GameState.upg_proj_dmg)
	$PopupPanel/TabContainer/Attack/ProjSpd.set_upgrade(GameState.upg_proj_speed)
	$PopupPanel/TabContainer/Attack/DetectRadius.set_upgrade(GameState.upg_detect_radius)
	$PopupPanel/TabContainer/Attack/AtkDelay.set_upgrade(GameState.upg_attack_delay)
	
func on_upgrades_click():
	$PopupPanel.popup()