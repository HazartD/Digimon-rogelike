extends Node
# funciona como creo pero tube que crear las carpetas y el archivo vacio manualmente
const USERDATA="user://HazartD/DR/Userdata.ini"
const CONFIG="user://HazartD/DR/Config.ini"
const SCREENSHOT_PATH="user://HazartD/DR/screenshot/ss%s.png"
const SEED_FILE_PATH="user://HazartD/DR/seed_register/%s.ini"
enum LOCATIONS{DS,NSP,DR,ME,JT,NSO,VB,WG,DA,UK,CRACK_TEAM_BASE,FILE_CITY,SHORE}

const ZONES:Dictionary={
	Vector2i(0, 0): LOCATIONS.DS,
	Vector2i(0, 1): LOCATIONS.DS,
	Vector2i(0, 2): LOCATIONS.DS,
	Vector2i(0, 3): LOCATIONS.DS,
	Vector2i(0, 4): LOCATIONS.DS,
	Vector2i(0, 5): LOCATIONS.DS,
	Vector2i(0, 6): LOCATIONS.DS,
	Vector2i(0, 7): LOCATIONS.DS,
	Vector2i(1, 0): LOCATIONS.DS,
	Vector2i(1, 1): LOCATIONS.DS,
	Vector2i(1, 2): LOCATIONS.WG,
	Vector2i(1, 3): LOCATIONS.JT,
	Vector2i(1, 4): LOCATIONS.JT,
	Vector2i(1, 5): LOCATIONS.JT,
	Vector2i(1, 6): LOCATIONS.DS,
	Vector2i(1, 7): LOCATIONS.DS,
	Vector2i(2, 0): LOCATIONS.DS,
	Vector2i(2, 1): LOCATIONS.WG,
	Vector2i(2, 2): LOCATIONS.WG,
	Vector2i(2, 3): LOCATIONS.JT,
	Vector2i(2, 4): LOCATIONS.JT,
	Vector2i(2, 5): LOCATIONS.JT,
	Vector2i(2, 6): LOCATIONS.JT,
	Vector2i(2, 7): LOCATIONS.DS,
	Vector2i(3, 0): LOCATIONS.DS,
	Vector2i(3, 1): LOCATIONS.WG,
	Vector2i(3, 2): LOCATIONS.WG,
	Vector2i(3, 3): LOCATIONS.NSP,
	Vector2i(3, 4): LOCATIONS.NSP,
	Vector2i(3, 5): LOCATIONS.NSP,
	Vector2i(3, 6): LOCATIONS.NSP,
	Vector2i(3, 7): LOCATIONS.DS,
	Vector2i(4, 0): LOCATIONS.DS,
	Vector2i(4, 1): LOCATIONS.DS,
	Vector2i(4, 2): LOCATIONS.NSP,
	Vector2i(4, 3): LOCATIONS.VB,
	Vector2i(4, 4): LOCATIONS.NSP,
	Vector2i(4, 5): LOCATIONS.NSP,
	Vector2i(4, 6): LOCATIONS.NSP,
	Vector2i(4, 7): LOCATIONS.DS,
	Vector2i(5, 0): LOCATIONS.DS,
	Vector2i(5, 1): LOCATIONS.DS,
	Vector2i(5, 2): LOCATIONS.VB,
	Vector2i(5, 3): LOCATIONS.VB,
	Vector2i(5, 4): LOCATIONS.WG,
	Vector2i(5, 5): LOCATIONS.NSP,
	Vector2i(5, 6): LOCATIONS.DS,
	Vector2i(5, 7): LOCATIONS.DS,
	Vector2i(6, 0): LOCATIONS.DS,
	Vector2i(6, 1): LOCATIONS.VB,
	Vector2i(6, 2): LOCATIONS.VB,
	Vector2i(6, 3): LOCATIONS.NSO,
	Vector2i(6, 4): LOCATIONS.NSO,
	Vector2i(6, 5): LOCATIONS.DS,
	Vector2i(6, 6): LOCATIONS.DS,
	Vector2i(6, 7): LOCATIONS.DS,
	Vector2i(7, 0): LOCATIONS.DS,
	Vector2i(7, 1): LOCATIONS.NSO,
	Vector2i(7, 2): LOCATIONS.NSO,
	Vector2i(7, 3): LOCATIONS.NSO,
	Vector2i(7, 4): LOCATIONS.NSO,
	Vector2i(7, 5): LOCATIONS.DS,
	Vector2i(7, 6): LOCATIONS.DS,
	Vector2i(7, 7): LOCATIONS.DS,
	Vector2i(8, 0): LOCATIONS.DS,
	Vector2i(8, 1): LOCATIONS.VB,
	Vector2i(8, 2): LOCATIONS.NSO,
	Vector2i(8, 3): LOCATIONS.NSO,
	Vector2i(8, 4): LOCATIONS.WG,
	Vector2i(8, 5): LOCATIONS.WG,
	Vector2i(8, 6): LOCATIONS.NSP,
	Vector2i(8, 7): LOCATIONS.DS,
	Vector2i(9, 0): LOCATIONS.DS,
	Vector2i(9, 1): LOCATIONS.VB,
	Vector2i(9, 2): LOCATIONS.NSO,
	Vector2i(9, 3): LOCATIONS.DR,
	Vector2i(9, 4): LOCATIONS.DR,
	Vector2i(9, 5): LOCATIONS.WG,
	Vector2i(9, 6): LOCATIONS.NSP,
	Vector2i(9, 7): LOCATIONS.DS,
	Vector2i(10, 0): LOCATIONS.DS,
	Vector2i(10, 1): LOCATIONS.ME,
	Vector2i(10, 2): LOCATIONS.ME,
	Vector2i(10, 3): LOCATIONS.ME,
	Vector2i(10, 4): LOCATIONS.DR,
	Vector2i(10, 5): LOCATIONS.DR,
	Vector2i(10, 6): LOCATIONS.DS,
	Vector2i(10, 7): LOCATIONS.DS,
	Vector2i(11, 0): LOCATIONS.DS,
	Vector2i(11, 1): LOCATIONS.ME,
	Vector2i(11, 2): LOCATIONS.ME,
	Vector2i(11, 3): LOCATIONS.ME,
	Vector2i(11, 4): LOCATIONS.ME,
	Vector2i(11, 5): LOCATIONS.DR,
	Vector2i(11, 6): LOCATIONS.DS,
	Vector2i(11, 7): LOCATIONS.DS,
	Vector2i(12, 0): LOCATIONS.DS,
	Vector2i(12, 1): LOCATIONS.DS,
	Vector2i(12, 2): LOCATIONS.DS,
	Vector2i(12, 3): LOCATIONS.DS,
	Vector2i(12, 4): LOCATIONS.DS,
	Vector2i(12, 5): LOCATIONS.DS,
	Vector2i(12, 6): LOCATIONS.DS,
	Vector2i(12, 7): LOCATIONS.DS}
#func para cargar el album de imagenes
	#var con=ConfigFile.new()
	#DirAccess.open("user://HazartD/DR/screenshot")
	#con.load(Iniload.SEED_FILE_PATH % Iniload.actual_seed)
	#for img in con.get_section_keys("screenshoot"):
		#var sprite=Sprite2D.new()
		#sprite.texture=ImageTexture.create_from_image(Image.load_from_file(con.get_value("screenshoot",img)))
		#add_child(sprite)

var world_seeds:Dictionary={}
var statsplus:Dictionary={"life":2.200,"energy":500.000,"attack":0.000,"defend":0.000,"speed":20.001,"inteligent":0.000,"will":0.000}
var unlock_evo:Dictionary={"meca_data":false,6:false,7:false,8:false,9:false}#son los id del digimon desbloqueado y su true false
var run_number:int=0
var location:LOCATIONS= LOCATIONS.NSP
var actual_seed:int=1923659980
var seed_string:String="Digimon"
var player_name:String

func _init()->void:
	DirAccess.make_dir_recursive_absolute("user://HazartD/DR/screenshot")
	DirAccess.make_dir_recursive_absolute("user://HazartD/DR/seed_register")
	#connect("tree_exiting",save_config,CONNECT_ONE_SHOT)
	#DirAccess.open("user://HazartD/DR")
	#if FileAccess.file_exists(USERDATA):load_userdata()
	#else:
		#var con=ConfigFile.new()
		#var user:String=OS.get_data_dir()
		#user=user.erase(0,9)
		#user=user.erase(user.find("/"),16)
		#con.set_value("first_run","why exist this section?","creo que necesita tener algo para crear el archivo y puse esto")
		#con.set_value("first_run","date",str(Time.get_datetime_dict_from_system()))
		#con.set_value("first_run","system",OS.get_name())
		#con.set_value("first_run","system_unique_id",OS.get_unique_id())
		#con.set_value("first_run","User_system_name",user)
		#con.set_value("first_run","Locale_language",OS.get_locale_language())
		#con.set_value("meta_progesion","unlock_evo",unlock_evo)
		#con.set_value("meta_progesion","run_number",run_number)
		#con.set_value("meta_progesion","location",location)
		#con.save(USERDATA)
	if FileAccess.file_exists(CONFIG):load_config()

func save_config()->void:
	var con=ConfigFile.new()
	con.load(CONFIG)
	con.set_value("general","languaje",TranslationServer.get_locale())
	con.set_value("general","windowmode",DisplayServer.window_get_mode())
	con.set_value("auidio","bgm",AudioServer.get_bus_volume_db(1))
	con.set_value("auidio","sfx",AudioServer.get_bus_volume_db(2))
	con.set_value("auidio","ui",AudioServer.get_bus_volume_db(3))
	con.save(CONFIG)

func load_config()->void:
	var con=ConfigFile.new()
	var err=con.load(CONFIG)
	if err != OK: return
	TranslationServer.set_locale(con.get_value("general","languaje"))
	DisplayServer.window_set_mode(con.get_value("general","windowmode"))
	AudioServer.set_bus_volume_db(1,con.get_value("auidio","bgm"))
	AudioServer.set_bus_volume_db(2,con.get_value("auidio","sfx"))
	AudioServer.set_bus_volume_db(3,con.get_value("auidio","ui"))

func get_section_player() -> String:return player_name+"("+str(run_number)+")"

func savedead(data:Dictionary)->void:
	var section=get_section_player()
	run_number+=1
	var con=ConfigFile.new()
	con.load(USERDATA)
	con.set_value("meta_progesion","unlock_evo",unlock_evo)
	con.set_value("meta_progesion","run_number",run_number)
	con.set_value("meta_progesion","location",location)
	for key in data.keys():
		if key !="player_name":
			con.set_value(section,key,data[key])
			if  key =="digimon_id" or key =="time" or key =="player_name" or key =="fighter" or key =="dead cause"or key =="line_id":continue
			elif statsplus[key] != data[key]: statsplus[key]+=(data[key]/1000)
	con.set_value("meta_progesion","statsplus",statsplus)
	con.save(USERDATA)

func load_userdata()->void:
	var con=ConfigFile.new()
	var _err=con.load(USERDATA)
	if con.has_section("meta_progesion"):
		unlock_evo=con.get_value("meta_progesion","unlock_evo")
		statsplus=con.get_value("meta_progesion","statsplus")
		run_number=con.get_value("meta_progesion","run_number")

func create_seed_regiser_file()->void:
	var con=ConfigFile.new()
	con.set_value("seed data","seed",actual_seed)
	con.set_value("seed data","text_1",seed_string)
	#for seed in world_seed: con.set_value("world seeds",str(seed),world_seed[seed])
	con.set_value("world_seeds","world_seeds",world_seeds)
	con.save(SEED_FILE_PATH % actual_seed)

func add_seed_string_to_seed_file(_seed:int,stri:String)->void:#cuando creas un mundo debe comprobar si la string da una seed ya registrada y negarte crear otro
	var con=ConfigFile.new()
	con.load(SEED_FILE_PATH % _seed)
	var number:int=1
	while con.has_section_key("seed data","text_%s"%number):
		if stri==con.get_value("seed data","text_%s"%number):break
		number+=1
	con.set_value("seed data","text_%s"%number,stri)

#func _input(event)->void:
	#if event.is_action_pressed("screenshot"):
		#var screenshoot_number:int=1
		#var path=SCREENSHOT_PATH % screenshoot_number
		#while FileAccess.file_exists(path):
			#screenshoot_number+=1
			#path=SCREENSHOT_PATH % screenshoot_number
		#var _imagen=get_viewport().get_texture().get_image().save_png(path)
		#if actual_seed:
			#var con=ConfigFile.new()
			#con.load(SEED_FILE_PATH % actual_seed)
			#con.set_value("screenshoot",str(screenshoot_number)+" ("+get_section_player()+")",path)
			#con.save(SEED_FILE_PATH % actual_seed)
