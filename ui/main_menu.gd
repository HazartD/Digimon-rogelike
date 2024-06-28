extends Control
const SEED_PREVIEW:PackedStringArray=["NS","IS","SS","ES"]
const PATH:String="user://HazartD/DR/seed_register/"
@onready var seed_into=$main/main/seed/TextEdit
@onready var seed_preview=$main/main/seed/Label
@onready var digimon_preview=$main/main/selec_digi/selec_digi/digimon
@onready var name_player=$main/main/seed/name
var rng=RandomNumberGenerator.new()
#Iniload.SEED_FILE_PATH.erase(32,7)
func determinar_field():
	rng.seed=Iniload.actual_seed
	for an in 1:for al in 3:Iniload.world_seeds[Vector2i(an,al)]=rng.randi()#al final borrar esta linea
	#for an in 13:for al in 8:Iniload.world_seeds[Vector2i(an,al)]=randi() #este es el bueno
	Iniload.create_seed_regiser_file()

func _on_text_edit_text_changed():
	if seed_into.text=="":seed_preview.text=SEED_PREVIEW[0]# ifseed_preview.text!=SEED_PREVIEW[0]:
	elif seed_into.text.is_valid_int():seed_preview.text=SEED_PREVIEW[1]
	else:seed_preview.text=SEED_PREVIEW[2]

func _on_button_button_down():
	Iniload.player_name=name_player.text
	randomize()
	Iniload.seed_string=""
	if seed_into.text=="":
		Iniload.actual_seed=randi()
	elif seed_into.text.is_valid_int():
		Iniload.actual_seed=int(seed_into.text)
	else:
		Iniload.actual_seed=hash(seed_into.text)
		Iniload.seed_string=seed_into.text
		
	if DirAccess.open(PATH).get_files().has(str(Iniload.actual_seed)+".ini"):
		if seed_preview.text==SEED_PREVIEW[2]:Iniload.add_seed_string_to_seed_file(Iniload.actual_seed,Iniload.seed_string)
		seed_preview.text=SEED_PREVIEW[3]
	else:determinar_field()

func _on_config_button_down():
	var con=Resouses.MENU_OPTIONS.instantiate()
	add_child(con)

func _on_logros_button_down():
	var logro=Resouses.USER_DATA.instantiate()
	add_child(logro)

func _on_credi_button_down():
	pass # Replace with function body.
