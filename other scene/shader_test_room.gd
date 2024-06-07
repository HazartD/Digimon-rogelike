extends Node2D
@onready var sprite=$"400Px-folderContinent"
func _ready():
	sprite.material.shader=Resouses.DEAD
	sprite.material.set("shader_parameter/noise_tex_normal",Resouses.NOISE_NORMAL)
	sprite.material.set("shader_parameter/noise_tex",Resouses.NOISE)
	sprite.material.set("shader_parameter/progress",0.5)
	
