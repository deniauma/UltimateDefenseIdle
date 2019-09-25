extends Button

var enable_color = Color(1, 1, 1)
var disable_color = Color(0.5, 0.5, 0.5)
onready var btn_label = $Text/Label
onready var price_label = $Text/Price

func disable_button(disabled: bool):
	self.disabled = disabled
	if disabled:
		btn_label.add_color_override("font_color", disable_color)
		price_label.add_color_override("font_color", disable_color)
	else:
		btn_label.add_color_override("font_color", enable_color)
		price_label.add_color_override("font_color", enable_color)
		
