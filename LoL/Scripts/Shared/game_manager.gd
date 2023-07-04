extends Node

# Signals to track basic stats
signal player_health_changed(new_health)
signal player_mana_changed(new_mana)
signal player_stamina_changed(new_stamina)

signal mob_died(exp_value)

@onready var player = preload("res://Scenes/Characters/Player/player.tscn").instantiate()


func _ready() -> void:
	# Player signals
	player.init_player()
	player.connect("player_health_changed", _on_player_health_changed)
	player.connect("player_mana_changed", _on_player_mana_changed)

func _on_player_health_changed(amount : float) -> void:
	emit_signal("player_health_changed", amount)

func _on_player_mana_changed(amount : float) -> void:
	emit_signal("player_mana_changed", amount)
