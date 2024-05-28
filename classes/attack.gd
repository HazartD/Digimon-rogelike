class_name Attack extends TextureRect
var reposo:float=0
@export var physic:bool#si es fisico true y si intelig false
@export var energy_use:bool=false
@onready var digimon_owner:DigimonBody=get_parent().get_parent().get_parent().get_parent()
@export_enum("none:0","rapid:1","low:3","medium:5","high:7") var kooldown=1
@export_enum("PASIVE","MELEE","RANGE","RANGE_PERSIT","EMBEST","AREA")var Type=0
@export_range(0,2) var power_atack:float=1.0
@onready var atribut:DigimonCORE.attribut=digimon_owner.attribute
func powered()->float:
	if physic:return power_atack*digimon_owner.get_attack()
	else:return power_atack*digimon_owner.get_inteligent()

func _process(delta):
	if reposo<=0.0:
		if modulate!=Color(1,1,1,1):modulate=Color(1,1,1,1)
	else: 
		reposo-=delta
		if modulate!=Color(0.3,0.3,0.3,0.3):modulate=Color(0.3,0.3,0.3,0.3)
	$Label.text=str(reposo)
	

