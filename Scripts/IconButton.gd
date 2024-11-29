extends TextureButton

const offset = Vector2(53, 50)
var buttonPress = false
var originalPos = position
var used = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if buttonPress: # When the button is pressed, make it travel to the mouse's position
		position = get_viewport().get_mouse_position() - offset # Offset exists because the button origin is top left corner
	if get_meta("iconID") in GlobalVars.picked_polos: # Disables the icon when the polo is in use
		used = true
	else:
		used = false


func _when_self_button_down() -> void:
	if !used:
		buttonPress = true
		GlobalVars.mouse_up = false
		GlobalVars.carrying_icon = true
		print("Icon is being carried")


func _when_self_button_up() -> void:
	if !used:
		print("Icon released")
		buttonPress = false
		GlobalVars.mouse_up = true # Mouse button has been released
		GlobalVars.icon_meta = get_meta("iconID")
		position = originalPos # Return the icon to its original place
	
	if get_meta("iconID") not in GlobalVars.picked_polos:
		GlobalVars.carrying_icon = false
		await get_tree().create_timer(0.1).timeout # waits for 1 second
		GlobalVars.icon_meta = 0
