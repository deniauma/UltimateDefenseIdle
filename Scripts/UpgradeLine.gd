extends HBoxContainer

var upgrade: Upgrade
onready var title_label = $VBoxContainer/Title
onready var lvl_label = $VBoxContainer/Level
onready var buy1_btn = $BuyButtons/BuyOne
onready var effect_label = $VBoxContainer/Effect

func _ready():
	buy1_btn.connect("pressed", self, "on_buy1_click")
	add_to_group("upgrades_ui")
	
func _physics_process(delta):
#	buy1_btn.disabled = not upgrade.can_buy_next_upgrade()
	buy1_btn.disable_button(not upgrade.can_buy_next_upgrade())

func set_upgrade(upg: Upgrade):
	upgrade = upg
	title_label.text = upgrade.name
	update_ui()
	
func update_ui():
	lvl_label.text = "Lvl " + str(upgrade.level)
	$BuyButtons/BuyOne/Text/Price.text = str(upgrade.next_upgrade_price()) + "G"
	var plus = ""
	if upgrade.value_per_level > 0:
		plus = "+"
	effect_label.text = "Effect: " + str(upgrade.get_current_total_value()) + " " + upgrade.unit + "  (" + plus + str(upgrade.value_per_level) + " per level)"
	
func on_buy1_click():
	upgrade.buy_next_upgrade()
	update_ui()
	
