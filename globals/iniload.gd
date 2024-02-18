extends Node
# funciona como creo pero tube que crear las carpetas y el archivo vacio manualmente
var statsplus:Array[float]=[]
var unlock_evo:Array=[]
var run_number:int=1
var dirc=DirAccess.open("user://")
var file=FileAccess
func _init():
	DirAccess.make_dir_absolute("user://HazartD/DR")
	dirc=DirAccess.open("user://HazartD/DR")
	if FileAccess.file_exists("user://HazartD/DR/Userdata.ini"):load_userdata()
	else:
		var con=ConfigFile.new()
		con.set_value("first_run","why exist this section?","creo que necesita tener algo para crear el archivo y puse esto")
		con.set_value("first_run","date",str(Time.get_datetime_dict_from_system()))
		con.set_value("first_run","system",OS.get_name())
		con.save("user://HazartD/DR/Userdata.ini")

func save_config():
	var con=ConfigFile.new()
	con.set_value("general","languaje",TranslationServer.get_locale())
	con.set_value("general","windowmode",DisplayServer.window_get_mode())
	con.set_value("auidio","bgm",AudioServer.get_bus_volume_db(1))
	con.set_value("auidio","sfx",AudioServer.get_bus_volume_db(2))
	con.set_value("auidio","ui",AudioServer.get_bus_volume_db(3))
	con.save("user://HazartD/DR/Config.ini")






func load_userdata():
	var con=ConfigFile.new()
	var _err=con.load("user://HazartD/DR/Userdata.ini")

func savedead(data:Dictionary):
	var section="("+str(run_number)+")"+data["player_name"]
	var con=ConfigFile.new()
	var _err=con.load("user://HazartD/DR/Userdata.ini")
	for key in data.keys():
		if key !="player_name":
			con.set_value(section,key,data[key])
	con.save("user://HazartD/DR/Userdata.ini")
