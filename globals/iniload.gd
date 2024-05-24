extends Node
# funciona como creo pero tube que crear las carpetas y el archivo vacio manualmente
const USERDATA="user://HazartD/DR/Userdata.ini"
const CONFIG="user://HazartD/DR/Config.ini"
const SCREENSHOT_PATH="user://HazartD/DR/screenshot/ss%s.png"
const SEED_FILE_PATH="user://HazartD/DR/seed_register/%s.ini"
#func para cargar el album de imagenes
	#var con=ConfigFile.new()
	#DirAccess.open("user://HazartD/DR/screenshot")
	#con.load(Iniload.SEED_FILE_PATH % Iniload.actual_seed)
	#for img in con.get_section_keys("screenshoot"):
		#var sprite=Sprite2D.new()
		#sprite.texture=ImageTexture.create_from_image(Image.load_from_file(con.get_value("screenshoot",img)))
		#add_child(sprite)

var statsplus:Dictionary={"life":0.000,"energy":0.000,"attack":0.000,"defend":0.000,"speed":0.000,"inteligent":0.000,"will":0.000}
var unlock_evo:Dictionary={}#son los id del digimon desbloqueado y su true false
var run_number:int=1
enum Locations{NATURE_SPIRIT,DRAGON_ROAR,DEEP_SAVERS}
var location:Locations=Locations.NATURE_SPIRIT
var actual_seed:int=345678
var seed_string:String
var player_name:String
func _init():
	DirAccess.make_dir_absolute("user://HazartD/DR/screenshot")
	DirAccess.make_dir_absolute("user://HazartD/DR/seed_register")
	DirAccess.open("user://HazartD/DR")
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

func load_config():
	var con=ConfigFile.new()
	var err=con.load(CONFIG)
	if err != OK: return
	TranslationServer.set_locale(con.get_value("general","languaje"))
	DisplayServer.window_set_mode(con.get_value("general","windowmode"))
	AudioServer.set_bus_volume_db(1,con.get_value("auidio","bgm"))
	AudioServer.set_bus_volume_db(2,con.get_value("auidio","sfx"))
	AudioServer.set_bus_volume_db(3,con.get_value("auidio","ui"))

func get_section_player() -> String:
	return player_name+"("+str(run_number)+")"

func savedead(data:Dictionary):
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

func create_seed_regiser_file():
	var con=ConfigFile.new()
	con.set_value("seed data","seed",actual_seed)
	con.set_value("seed data","text_1",seed_string)
	con.save(SEED_FILE_PATH % actual_seed)

func add_seed_string_to_seed_file(_seed:int,stri:String):
	#cuando creas un mundo debe comprobar si la string da una seed ya registrada y negarte crear otro
	var con=ConfigFile.new()
	con.load(SEED_FILE_PATH % _seed)
	var number:int=2
	while con.has_section_key("seed data","text_%s"%number):
		number+=1
	con.set_value("seed data","text_%s"%number,stri)
	pass


func _input(event):
	if event.is_action_pressed("screenshot"):
		var screenshoot_number:int=1
		var path=SCREENSHOT_PATH % screenshoot_number
		while FileAccess.file_exists(path):
			screenshoot_number+=1
			path=SCREENSHOT_PATH % screenshoot_number
		var _imagen=get_viewport().get_texture().get_image().save_png(path)
		if actual_seed:
			var con=ConfigFile.new()
			con.load(SEED_FILE_PATH % actual_seed)
			con.set_value("screenshoot",str(screenshoot_number),path)
			con.save(SEED_FILE_PATH % actual_seed)

