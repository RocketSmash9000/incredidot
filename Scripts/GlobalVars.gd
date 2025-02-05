extends Node
# This script contains needed variables. Expect errors if you delete any
# Define variables here if you need to access them from multiple scripts
# Define variables under this comment and above func _ready()

var mouse_up = false # Controls when the mouse has been unclicked
var icon_meta = 0 # Metadata of the carried icon, aka its identifier
var carrying_icon = false # Self-explanatory

var mouse_in_top_part = false
var mouse_in_bottom_part = false

var picked_polos = [] # Used to keep track of the polos that have been picked

var reset = false # Self-explanatory

# Use these to set the time in seconds it takes to complete.
# And the amount of loops it takes to return to the first loop.
# The loop indicator does not support more than 2 loops.
# So you may want to add code to implement it.
# There may be a delay of around 0.05 seconds or less before audio plays.
# So if your sounds are 6 seconds, try subtracting 0.01 until the desired result.
var loop_seconds = 6
var loop_amount = 2
var current_loop = 1

# This variable stores the amount of sounds that the mod will have.
# To calculate this number just do 'number of polos * number of loops'.
# If there are polos that only have one loop, subtract 1 from the total calculated
# number for each polo that has only one loop. You will need to alter the
# sound playing code.
var total_sounds = 40

# This varaible contains a list of all polo sounds, including extra ones.
# All polo sounds contained in this list are in order
# meaning that index 0 corresponds to the first loop of the first polo.
# This is a self-managed variable. DO NOT modify it.
var all_sounds = []

# This variable contains all polo animations in the Assets folder.
# All files are in order, so index 0 is the animation for polo 1.
# This variable is also self-managed. Do not modify it
var polo_anims = []

func _ready() -> void:
	# Loads and adds every sound in the "Sound" directory to the all_sounds var
	# May be difficult to understand
	# Ignores files inside other directories
	var sound_dir = DirAccess.open("res://Sound/") # Change this path if you have a custom sound folder
	if sound_dir:
		sound_dir.list_dir_begin()
		var file_name = sound_dir.get_next()
		while file_name != "":
			if sound_dir.current_is_dir():
				pass
			else:
				if !file_name.begins_with(".") and !file_name.ends_with(".import") and !file_name.ends_with(".md"):
					all_sounds.append(load("res://Sound/" + file_name))
					Log.debug("Added and loaded " + "res://Sound/" + file_name)
			file_name = sound_dir.get_next()
	else:
		Log.fatal("Could not access the 'Sound' path. Please check it exits and is named correctly.")
		Log.info("Quitting automatically to prevent further errors...")
		get_tree().quit(1) # Error code 1 = Path to 'Sound' path not found
	
	if all_sounds.size() < total_sounds:
		Log.warn("One or more sounds could not be loaded or do not exist.")
	elif all_sounds.size() > total_sounds:
		Log.info("There are more sounds than polos. It won't break a thing, but the sounds occupy useless space")
	
	# This block loads all polo animations for later use
	# This forces all animations to be in a numbered folder with the name being the same as the name of its folder
	for h in range(1, (total_sounds/2) +1):
		polo_anims.append(load("res://Assets/" + str(h) + "/" + str(h) + ".tres"))
	
	# Note: to make animations you will need to put all individual frames in the
	# same folder as the animation file corresponding to each polo


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_viewport().get_mouse_position().y <= 728: # If this triggers, the mouse is in the top part
		mouse_in_top_part = true
		mouse_in_bottom_part = false
	
	if get_viewport().get_mouse_position().y > 728: # If this triggers, the mouse is in the bottom part
		mouse_in_bottom_part = true
		mouse_in_top_part = false
	
	if reset:
		await get_tree().create_timer(0.05).timeout # waits for 0.05 seconds
		picked_polos.clear() # Clears the list containing all currently picked polos
		current_loop = 1 # Resets the current loop to 1
		reset = false
		Log.debug("All polos reset!")
	
	# Sets the current loop to 1 if there are no picked polos
	if picked_polos.is_empty():
		current_loop = 1
