class_name Upgrade

var name: String
var base_value: int
var base_price: int
var value_per_level: int
var multiplier: float
var level: int = 0

func _init(name:String, baseValue: int, basePrice: int, vPerLvl: int, multiply: float = 1.10):
	self.name = name
	base_value = baseValue
	base_price = basePrice
	value_per_level = vPerLvl
	multiplier = multiply
	
func next_upgrade_price() -> int:
	return floor(base_price * pow(multiplier, level)) as int
	
func can_buy_next_upgrade() -> bool:
	return GameState.gold >= next_upgrade_price()
	
func buy_next_upgrade():
	var price = next_upgrade_price()
	if GameState.gold >= price:
		GameState.gold -= price
		level += 1
		GameState.update_player_stats()

func get_current_total_value() -> int:
	return base_value + level * value_per_level

