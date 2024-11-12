extends Node3D

var health : Need
var hunger : Need
var thirst : Need
var sleep : Need

@export var no_hunger_health_decay : float
@export var no_thirst_health_decay : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = get_node("Health")
	hunger = get_node("Hunger")
	thirst = get_node("Thirst")
	sleep = get_node("Sleep")
	
	health.value = health.start_value
	hunger.value = hunger.start_value
	thirst.value = thirst.start_value
	sleep.value = sleep.start_value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hunger.subtract(hunger.decay_rate * delta)
	thirst.subtract(thirst.decay_rate * delta)
	sleep.add(sleep.regen_rate * delta)
	
	if hunger.value == 0:
		health.subtract(no_hunger_health_decay * delta)
		
	if thirst.value == 0:
		health.subtract(no_thirst_health_decay * delta)
	
	if health.value == 0:
		print("Die")
	
	health.update_ui_bar()
	hunger.update_ui_bar()
	thirst.update_ui_bar()
	sleep.update_ui_bar()

func eat(amount):
	hunger.add(amount)
