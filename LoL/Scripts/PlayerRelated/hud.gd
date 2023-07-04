class_name HUD
extends Control


@onready var health_bar := $StatsBars/HealthBar
@onready var mana_bar := $StatsBars/ManaBar
@onready var stamina_bar := $StatsBars/StaminaBar
@onready var health_amount := $StatsBars/HealthBar/HealthNumber
@onready var mana_amount := $StatsBars/ManaBar/ManaNumber
@onready var stamina_amount := $StatsBars/StaminaBar/StaminaNumber

@onready var game_manager = preload("res://Scenes/Singleton/game_manager.tscn").instantiate()

func _ready() -> void:
	game_manager.player_health_changed.connect(on_player_health_changed)
	game_manager.player_mana_changed.connect(on_player_mana_changed)
	game_manager.player_stamina_changed.connect(on_player_stamina_changed)

func on_player_health_changed(amount : float) -> void:
	health_amount.text = str(amount)
	health_bar.value = amount

func on_player_mana_changed(amount : float) -> void:
	stamina_bar.value = amount
	stamina_amount.text = str(amount)

func on_player_stamina_changed(amount : float) -> void:
	mana_bar.value = amount
	mana_amount.text = str(amount)

func set_healthbar(player : Player) -> void:
	health_bar.max_value = player.max_health
	health_bar.value = player.health
	health_amount.text = str(player.health)
