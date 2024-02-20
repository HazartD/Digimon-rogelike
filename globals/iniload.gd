extends Node
# funciona como creo pero tube que crear las carpetas y el archivo vacio manualmente
var statsplus:Dictionary={"life":0.000,"energy":0.000,"attack":0.000,"defend":0.000,"speed":0.000,"inteligent":0.000,"will":0.000}
var unlock_evo:Dictionary={}#son los id del digimon desbloqueado
var run_number:int=1
const USERDATA="user://HazartD/DR/Userdata.ini"
const CONFIG="user://HazartD/DR/Config.ini"
enum Locations{NATURE_SPIRIT}
var location:Locations=Locations.NATURE_SPIRIT
func _init():
	DirAccess.make_dir_absolute("user://HazartD/DR")
	DirAccess.open("user://HazartD/DR")
	if FileAccess.file_exists(USERDATA):load_userdata()
	else:
		var con=ConfigFile.new()
		con.set_value("first_run","why exist this section?","creo que necesita tener algo para crear el archivo y puse esto")
		con.set_value("first_run","date",str(Time.get_datetime_dict_from_system()))
		con.set_value("first_run","system",OS.get_name())
		con.save(USERDATA)
func save_config():
	var con=ConfigFile.new()
	con.set_value("general","languaje",TranslationServer.get_locale())
	con.set_value("general","windowmode",DisplayServer.window_get_mode())
	con.set_value("auidio","bgm",AudioServer.get_bus_volume_db(1))
	con.set_value("auidio","sfx",AudioServer.get_bus_volume_db(2))
	con.set_value("auidio","ui",AudioServer.get_bus_volume_db(3))
	con.save(CONFIG)





func load_userdata():
	var con=ConfigFile.new()
	var _err=con.load(USERDATA)
	if con.has_section("meta_progesion"):
		unlock_evo=con.get_value("meta_progesion","unlock_evo")
		statsplus=con.get_value("meta_progesion","statsplus")
		run_number=con.get_value("meta_progesion","run_number")

func savedead(data:Dictionary):
	var section="("+str(run_number)+")"+data["digimon_name"]
	run_number+=1
	var con=ConfigFile.new()
	var _err=con.load(USERDATA)
	con.set_value("meta_progesion","statsplus",statsplus)
	con.set_value("meta_progesion","unlock_evo",unlock_evo)
	con.set_value("meta_progesion","run_number",run_number)
	con.set_value("meta_progesion","location",location)
	
	for key in data.keys():
		if key !="player_name":
			con.set_value(section,key,data[key])
			if  key =="digimon_id" or key =="time" or key =="digimon_name":continue
			else:
				statsplus[key]+=(data[key]/10000)
	
	con.save(USERDATA)
