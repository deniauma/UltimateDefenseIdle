extends HBoxContainer

var upgrade: Upgrade
onready var title_label = $VBoxContainer/Title
onready var lvl_label = $VBoxContainer/Level
onready var buy1_btn = $BuyOne

func _ready():
	buy1_btn.connect("pressed", self, "on_buy1_click")
	add_to_group("upgrades_ui")
	
func _physics_process(delta):
	buy1_btn.disabled = not upgrade.can_buy_next_upgrade()

func set_upgrade(upg: Upgrade):
	upgrade = upg
	title_label.text = upgrade.name
	update_ui()
	
func update_ui():
	lvl_label.text = "Lvl " + str(upgrade.level)
	
func on_buy1_click():
	upgrade.buy_next_upgrade()
	update_ui()
	
