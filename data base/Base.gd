extends Node

var base:Dictionary={}
func _ready():
	var data_base=FileAccess.open("res://data base/Base.csv",FileAccess.READ)
	var _keys= data_base.get_csv_line(";")
	while data_base.get_position() < data_base.get_length():
		var new_digimon_data_unconver=data_base.get_csv_line(";")
#		print(new_digimon_data_unconver)
		var new_digimon_data:Array=[]
		for a in new_digimon_data_unconver:
			if a== new_digimon_data_unconver[1]:new_digimon_data+=[a]
			#elif a== "true":new_digimon_data+=[true]
			#elif a== "false":new_digimon_data+=[false]
			else:new_digimon_data+=[int(a)]
#			print(a)
		base[new_digimon_data[0] as int]=new_digimon_data
		#print(new_digimon_data)
	#print(base)
