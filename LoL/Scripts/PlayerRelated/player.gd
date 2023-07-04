extends CharacterBody2D
class_name Player

signal initialize_player

@onready var hitbox := $HitBox
@onready var anim := $AnimationPlayer

@export var max_health : float = 100.0
@export var max_mana := 100.0
@export var max_stamina := 100.0

var health : float = max_health:
	set(value):
		if value < health:
			print(health)
		elif value > health:
			print("this'll do for now")
		health = value
var mana : float = max_mana:
	set(value):
		if value < mana:
			print(mana)
		elif value > mana:
			print("I summon the power of the gods!")
		mana = value
var stamina : float = max_stamina:
	set(value):
		if value < stamina:
			print(stamina)
		elif value > stamina:
			print("Bruh you drained...")
		stamina = value

@export var sprint_speed := 500.0
@export var init_move_speed := 200.0
@export_range(0.01, 1.0) var drag_factor := 0.15

var move_speed : float


func _ready() -> void:
	move_speed = init_move_speed
	set_health(max_health)
	set_mana(max_mana)
	set_stamina(max_stamina)

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var desired_velocity := direction * move_speed
	var steering := desired_velocity - velocity
	
	if Input.is_action_pressed("sprint") and stamina > 0.0:
		move_speed = sprint_speed
	else:
		move_speed = init_move_speed
	
	velocity += steering * drag_factor
	
	move_and_slide()

func set_health(new_health : float) -> void:
	new_health = clamp(new_health, 0.0, max_health)
	health = new_health

func set_mana(new_mana : float) -> void:
	new_mana = clamp(new_mana, 0.0, max_mana)
	GameManager.emit_signal("player_mana_changed")

func set_stamina(new_stamina : float) -> void:
	new_stamina = clamp(new_stamina, 0.0, max_stamina)
	GameManager.emit_signal("player_stamina_changed")

func init_player() -> void:
	set_health(health)
	set_mana(mana)
	set_stamina(stamina)

func take_damage(amount : float) -> void:
	GameManager.player_health_changed.emit()
	
	set_health(health - amount)
	
	# If health becomes Zero or lower disable input to the player
	if health <= 0.0:
		disable()

func disable() -> void:
	set_process(false)
	set_physics_process(false)
	collision_layer = 0
	collision_mask = 0
