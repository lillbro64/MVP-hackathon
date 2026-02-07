extends Node

var component_max = 5
var component_total = 0
var component_stack: Array[Component]
var stack_changed = false

var potion_inventory: Array[Potion]

var player_value = 0
var player_max_health = 100
var player_health = 100
var player_stam_max: float = 100
var player_speed_mod = 2
var player_strength = 0

var has_won = false
var has_lost = false
