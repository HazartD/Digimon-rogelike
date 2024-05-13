class_name Attack extends Sprite2D
@export var energy_use:bool=true
@onready var digimon_owner:DigimonBody=get_parent().get_parent().get_parent().get_parent()
@export_enum("PASIVE","MELEE","RANGE","RANGE_PERSIT","EMBEST")var Type=0
@export var power_atack:float
@onready var atribut:DigimonCORE.attribut=digimon_owner.attribute
@onready var power:float#=power_atack*digimon_owner.get_attack()

