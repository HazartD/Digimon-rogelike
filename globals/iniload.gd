extends Node
const USERDATA="user://Userdata.ini"
const CONFIG="user://Config.ini"
const SCREENSHOT_PATH="user://screenshot/ss%s.png"
const SEED_FILE_PATH="user://seed_register/%s.ini"
const SCREENSHOT_FILE="user://screenshot.ini"
signal screenshot(path:String, texture:Texture)

var world_seeds:Dictionary={Vector2i.ZERO:34567890987}
var statsplus:Dictionary={"life":2.200,"energy":500.000,"attack":40.005,"defend":400.000,"speed":2500.001,"inteligent":400.000,"will":400.000}
var unlock_evo:Dictionary={"meca_data":false,6:false,7:false,8:false,9:false}#son los id del digimon desbloqueado y su true false
var run_number:int=0
var location:Base.LOCATIONS= Base.LOCATIONS.NSP
var actual_seed:int=1923659980
var seed_string:String="Digimon"
var player_name:String="Requeson"
var con_screen:ConfigFile=ConfigFile.new()

func _init()->void:
	connect("screenshot",Resouses.add_screenshot)
	DirAccess.make_dir_recursive_absolute("user://screenshot")
	DirAccess.make_dir_recursive_absolute("user://seed_register")
	#connect("tree_exiting",save_config,CONNECT_ONE_SHOT)
	#if FileAccess.file_exists(USERDATA):load_userdata()
	#else:
		#var con=ConfigFile.new()
		#var user:String=OS.get_data_dir().erase(0,9)
		#user=user.erase(user.find("/"),16)
		#con.set_value("first_run","why exist this section?","de inicio crei que necesita tener algo para crear el archivo y puse esto, pero mi error era durante la creacion de las carpetas")
		#con.set_value("first_run","date",str(Time.get_datetime_dict_from_system()))
		#con.set_value("first_run","system",OS.get_name())
		#con.set_value("first_run","system_unique_id",OS.get_unique_id())
		#con.set_value("first_run","User_system_name",user)
		#con.set_value("first_run","Locale_language",OS.get_locale_language())
		#con.set_value("meta_progesion","unlock_evo",unlock_evo)
		#con.set_value("meta_progesion","run_number",run_number)
		#con.set_value("meta_progesion","location",location)
		#con.save(USERDATA)
	#if FileAccess.file_exists(CONFIG):load_config()
	if FileAccess.file_exists(SCREENSHOT_FILE):con_screen.load(SCREENSHOT_FILE)

func get_section_player() -> String:return player_name+"("+str(run_number)+")"
func _input(event)->void:
	if event.is_action_pressed("screenshot"):
		var _name=Time.get_datetime_string_from_system()+"_ms"+str(Time.get_ticks_msec())
		_name=_name.replace(":","-")
		var path=SCREENSHOT_PATH % _name
		var imagen=get_viewport().get_texture().get_image()
		con_screen.set_value(str(actual_seed),get_section_player()+ "("+_name+")",path)
		con_screen.save(SCREENSHOT_FILE)
		imagen.save_png(path)
		emit_signal("screenshot",path,ImageTexture.create_from_image(imagen))

#
#func save_config()->void:
	#var con=ConfigFile.new()
	#con.load(CONFIG)
	#con.set_value("general","languaje",TranslationServer.get_locale())
	#con.set_value("general","windowmode",DisplayServer.window_get_mode())
	#con.set_value("auidio","bgm",AudioServer.get_bus_volume_db(1))
	#con.set_value("auidio","sfx",AudioServer.get_bus_volume_db(2))
	#con.set_value("auidio","ui",AudioServer.get_bus_volume_db(3))
	#con.save(CONFIG)
#
#func load_config()->void:
	#var con=ConfigFile.new()
	#var err=con.load(CONFIG)
	#if err != OK: return
	#TranslationServer.set_locale(con.get_value("general","languaje"))
	#DisplayServer.window_set_mode(con.get_value("general","windowmode"))
	#AudioServer.set_bus_volume_db(1,con.get_value("auidio","bgm"))
	#AudioServer.set_bus_volume_db(2,con.get_value("auidio","sfx"))
	#AudioServer.set_bus_volume_db(3,con.get_value("auidio","ui"))
#
#func savedead(data:Dictionary)->void:
	#var section=get_section_player()
	#run_number+=1
	#var con=ConfigFile.new()
	#con.load(USERDATA)
	#con.set_value("meta_progesion","unlock_evo",unlock_evo)
	#con.set_value("meta_progesion","run_number",run_number)
	#con.set_value("meta_progesion","location",location)
	#for key in data.keys():
		#if key !="player_name":
			#con.set_value(section,key,data[key])
			#if  key =="digimon_id" or key =="time" or key =="player_name" or key =="fighter" or key =="dead cause"or key =="line_id":continue
			#elif statsplus[key] != data[key]: statsplus[key]+=(data[key]/1000)
	#con.set_value("meta_progesion","statsplus",statsplus)
	#con.save(USERDATA)
#
#func load_userdata()->void:
	#var con=ConfigFile.new()
	#var _err=con.load(USERDATA)
	#if con.has_section("meta_progesion"):
		#unlock_evo=con.get_value("meta_progesion","unlock_evo")
		#statsplus=con.get_value("meta_progesion","statsplus")
		#run_number=con.get_value("meta_progesion","run_number")
#
#func create_seed_regiser_file()->void:
	#var con=ConfigFile.new()
	#con.set_value("seed data","seed",actual_seed)
	#con.set_value("seed data","text_1",seed_string)
	##for seed in world_seed: con.set_value("world seeds",str(seed),world_seed[seed])
	#con.set_value("world_seeds","world_seeds",world_seeds)
	#con.save(SEED_FILE_PATH % actual_seed)
#
#func add_seed_string_to_seed_file(_seed:int,stri:String)->void:#cuando creas un mundo debe comprobar si la string da una seed ya registrada y negarte crear otro
	#var con=ConfigFile.new()
	#con.load(SEED_FILE_PATH % _seed)
	#var number:int=1
	#while con.has_section_key("seed data","text_%s"%number):
		#if stri==con.get_value("seed data","text_%s"%number):break
		#number+=1
	#con.set_value("seed data","text_%s"%number,stri)
	#con.save(SEED_FILE_PATH % _seed)
