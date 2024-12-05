extends Area2D
# Define variables under this comment and above func _ready()

var mouse_in = false
var picked = false
var type = 0
var polo_sound = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if mouse_in and GlobalVars.mouse_in_top_part: # If the mouse is on top of the polo and is in the top part
		if GlobalVars.mouse_up and !picked and GlobalVars.icon_meta != 0: # And if everything looks to be correct
			mouse_in = false
			GlobalVars.mouse_up = false
			picked = true # Sets itself to picked
			type = GlobalVars.icon_meta # Fetches the metadata of the icon
			GlobalVars.carrying_icon = false
			print("Polo number ", get_meta("PoloID"), " picked with type ", type)
			GlobalVars.picked_polos.append(type) # Adds polo to the used list
			GlobalVars.icon_meta = 0 # Clears the icon metadata
			polo_sound = "res://Sound/" + str(type) + "/" + str(GlobalVars.current_loop)
		
		if Input.is_action_just_pressed("ui_click") and !GlobalVars.carrying_icon and picked:
			print("Polo number ", get_meta("PoloID"), " unpicked")
			GlobalVars.picked_polos.erase(type) # Removes polo type from used list
			type = 0 # Returns itself to original value
			picked = false # Sets polo to unused state
			GlobalVars.mouse_up = false
			# Here the code that stops the sound of the specific polo
	
	if GlobalVars.reset: # Resets the polo when the reset is called
		type = 0
		picked = false
		# Note: here goes the code that stops the sound for all specific polos
	
	# TODO: When the current loop changes, load and play the next loop


func _when_self_mouse_entered() -> void:
	mouse_in = true


func _when_self_mouse_exited() -> void:
	mouse_in = false
