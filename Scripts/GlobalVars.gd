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

func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_viewport().get_mouse_position().y <= 728: # If this triggers, the mouse is in the top part
		mouse_in_top_part = true
		mouse_in_bottom_part = false
	
	if get_viewport().get_mouse_position().y > 728: # If this triggers, the mouse is in the bottom part
		mouse_in_bottom_part = true
		mouse_in_top_part = false
	
	if reset:
		await get_tree().create_timer(0.005).timeout # waits for 0.05 seconds
		picked_polos.clear() # Clears the list containing all currently picked polos
		current_loop = 1 # Resets the current loop to 1
		reset = false
		Log.debug("All polos reset!")
	
	# Sets the current loop to 1 if there are no picked polos
	if picked_polos.is_empty():
		current_loop = 1

func set_polo_animation(meta):
	match meta:
		1:
			return load("res://Assets/1/1.tres")
		2:
			return load("res://Assets/2/2.tres")
		3:
			return load("res://Assets/3/3.tres")
		4:
			return load("res://Assets/4/4.tres")
		5:
			return load("res://Assets/5/5.tres")
		6:
			return load("res://Assets/6/6.tres")
		7:
			return load("res://Assets/7/7.tres")
		8:
			return load("res://Assets/8/8.tres")
		9:
			return load("res://Assets/9/9.tres")
		10:
			return load("res://Assets/10/10.tres")
		11:
			return load("res://Assets/11/11.tres")
		12:
			return load("res://Assets/12/12.tres")
		13:
			return load("res://Assets/13/13.tres")
		14:
			return load("res://Assets/14/14.tres")
		15:
			return load("res://Assets/15/15.tres")
		16:
			return load("res://Assets/16/16.tres")
		17:
			return load("res://Assets/17/17.tres")
		18:
			return load("res://Assets/18/18.tres")
		19:
			return load("res://Assets/19/19.tres")
		20:
			return load("res://Assets/20/20.tres")
