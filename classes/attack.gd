class_name Attack extends Sprite2D
@onready var digimon_owner:DigimonCORE=get_node("../../..")
@export_enum("PASIVE","MELEE","RANGE","RANGE_PERSIT","EMBEST")var Type=0
@export var power:int

