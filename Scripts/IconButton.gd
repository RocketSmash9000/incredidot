extends TextureButton

const offset = Vector2(53, 50)
var buttonPress = false
var originalPos = position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if buttonPress: # When the button is pressed, make it travel to the mouse's position
		position = get_viewport().get_mouse_position() - offset # Offset exists because the button origin is top left corner


func _when_self_button_down() -> void:
	buttonPress = true
	GlobalVars.mouse_up = false
	GlobalVars.carrying_icon = true
	print("Icon is being carried")


func _when_self_button_up() -> void:
	print("Icon released")
	buttonPress = false
	GlobalVars.mouse_up = true # Trigger mouse has been released
	GlobalVars.icon_meta = get_meta("iconID")
	position = originalPos # Return the icon to its original place
