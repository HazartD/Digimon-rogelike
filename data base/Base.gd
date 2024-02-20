extends Node
var base:Dictionary={}
func _ready():
	var data_base=FileAccess.open("res://data base/Base.csv",FileAccess.READ)
	var keys= data_base.get_csv_line()
	while data_base.get_position() < data_base.get_length():
		var new_digimon_data=data_base.get_csv_line()
		print(new_digimon_data)
		var dicti={}
		var data_index=0
		while !data_index>10:
			if data_index==1:dicti[keys[data_index]]=new_digimon_data[data_index]
			else:dicti[keys[data_index]]=int(new_digimon_data[data_index])
			data_index+=1
		base[new_digimon_data[0] as int]=dicti
	print(base)
