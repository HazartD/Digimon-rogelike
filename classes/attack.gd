class_name Attack extends Sprite2D
@export var energy_use:bool=false
@onready var digimon_owner:DigimonBody=get_parent().get_parent().get_parent().get_parent()
@export_enum("none:0","rapid:1","low:3","medium:5","high:7") var kooldown=3
@export_enum("PASIVE","MELEE","RANGE","RANGE_PERSIT","EMBEST")var Type=0
@export_range(0,2) var power_atack:float
@onready var atribut:DigimonCORE.attribut=digimon_owner.attribute
@onready var power:float=105#power_atack*digimon_owner.get_attack()

