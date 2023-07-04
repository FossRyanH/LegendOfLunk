extends Node2D

@onready var player := $Player
@onready var hud := $CanvasLayer/HUD
@onready var healthbar := $CanvasLayer/HUD/StatsBars/HealthBar

@onready var button_damage := $CanvasLayer/ButtonDamage


func _ready() -> void:
	hud.set_healthbar(GameManager.player)
