class_name WeaponManager
extends Node2D

var current_weapon : WeaponBase
var weapon_list : Array[WeaponBase]
var hands : PackedScene = preload("res://scenes/weapons/melee/hands.tscn")
var pistol : PackedScene = preload("res://scenes/weapons/ranged/pistol.tscn")
var rifle : PackedScene = preload("res://scenes/weapons/ranged/rifle.tscn")
var shotgun : PackedScene = preload("res://scenes/weapons/ranged/shotgun.tscn")
var current_animation : StringName = "idle"
var current_facing_dir : StringName = "down"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_instantiate_inventory()
	_add_children()
	_initial_config()
	pass # Replace with function body.

func _instantiate_inventory():
	weapon_list.append(hands.instantiate())
	weapon_list.append(pistol.instantiate())
	weapon_list.append(rifle.instantiate())
	weapon_list.append(shotgun.instantiate())
	_set_visible_inv()

func _set_visible_inv():
	weapon_list.get(0).visible = false
	weapon_list.get(1).visible = false
	weapon_list.get(2).visible = false
	weapon_list.get(3).visible = false

func _add_children():
	add_child(weapon_list.get(0))
	add_child(weapon_list.get(1))
	add_child(weapon_list.get(2))
	add_child(weapon_list.get(3))

func _initial_config():
	current_weapon = weapon_list.get(0)
	current_weapon.visible = true

func attack_current_weapon():
	current_weapon.attack()

func change_animation(anim_name : String, facing_dir : String) -> void:
	current_animation = StringName(anim_name)
	current_facing_dir = StringName(facing_dir)
	current_weapon.change_animation(anim_name, facing_dir)

func switch_weapon(weapon_slot : int):
	current_weapon.visible = false
	current_weapon = weapon_list.get(weapon_slot-1)
	current_weapon.visible = true
	current_weapon.change_animation(current_animation, current_facing_dir)
