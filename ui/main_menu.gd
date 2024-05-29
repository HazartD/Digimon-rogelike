extends Control
const SEED_PREVIEW:PackedStringArray=["NS","IS","SS","ES"]
const ZONES_ID:Array[int]=[1,2,3,4,5,6]
const PATH:String="user://HazartD/DR/seed_register/"
#Iniload.SEED_FILE_PATH.erase(32,7)
var files:PackedStringArray
func _ready():files=DirAccess.open(PATH).get_files()
func determinar_field():
	seed(Iniload.actual_seed)
	for an in 1:for al in 3:Iniload.world_seeds[Vector2i(an,al)]=[randi()]
	for map in Iniload.world_seeds.keys():
		#aqui debe comprobar latitud y logitud (paralelo X,meridiano Y,) y hechar a suerte en donde poner cada uno segun la location que tenga
		#tambien debo poner en el menu una imagen tipo "mapa actul" y es una imagen del metal encima del nature encima del deep, luego "lo planeado" y sea ya algo mas complejo con todos los field. Puedo poner un boton que los ordene al azar para practicar la logica de que decida ya encerio 
		#debo poner que el tile comprube la ubicacion, 
		match map.y:
			0:Iniload.world_seeds[map]+=[Iniload.LOCATIONS.CRACK_TEAM_BASE]
			1:Iniload.world_seeds[map]+=[Iniload.LOCATIONS.FILE_CITY]
			2:Iniload.world_seeds[map]+=[Iniload.LOCATIONS.SHORE]
	Iniload.create_seed_regiser_file()
func true_determinar_field():
	seed(Iniload.actual_seed)
	#var rng=RandomNumberGenerator.new()
	#rng.seed=Iniload.actual_seed
	for an in 13:for al in 8:
		Iniload.world_seeds[Vector2i(an,al)]=[randi()]
		if al==0 or al==7 or an==0 or an==12:Iniload.world_seeds[Vector2i(an,al)]+=[Iniload.LOCATIONS.DS]
		else:Iniload.world_seeds[Vector2i(an,al)]+=[ZONES_ID.pick_random()]
	Iniload.create_seed_regiser_file()

func _on_text_edit_text_changed():
	print("cambio texto")
	if $TextEdit.text=="":$Button/Label.text=SEED_PREVIEW[0]# if$Button/Label.text!=SEED_PREVIEW[0]:
	elif $TextEdit.text.is_valid_int():$Button/Label.text=SEED_PREVIEW[1]
	else:$Button/Label.text=SEED_PREVIEW[2]

func _on_button_button_down():
	if $TextEdit.text=="":
		print("null")
		randomize()
		Iniload.seed_string=""
		Iniload.actual_seed=randi()
	elif $TextEdit.text.is_valid_int():
		print("int")
		Iniload.seed_string=""
		Iniload.actual_seed=int($TextEdit.text)
	else:
		print("text")
		Iniload.actual_seed=hash($TextEdit.text)
		Iniload.seed_string=$TextEdit.text
	if files.has(str(Iniload.actual_seed)+".ini"):
		if $Button/Label.text==SEED_PREVIEW[2]:Iniload.add_seed_string_to_seed_file(Iniload.actual_seed,Iniload.seed_string)
		$Button/Label.text=SEED_PREVIEW[3]
	else:true_determinar_field()
