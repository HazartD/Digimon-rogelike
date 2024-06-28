extends MarginContainer
var images:Array[Texture]=[]
func load_screenshot_album(seed_:String="1923659980")->void:
	var con=ConfigFile.new()
	DirAccess.open("user://HazartD/DR/screenshot")
	con.load(Iniload.SEED_FILE_PATH % seed_)
	for img in con.get_section_keys("screenshoot"):
		images+=[ImageTexture.create_from_image(Image.load_from_file(con.get_value("screenshoot",img)))]
#talve para portada hacer que las screen tengan "seed_ss%s", que se busque el "_" y con menos -1 (o comprobarlo con cantidad de digitos+1), se hacer for a todas las imagenes hasta que la primera coinsida y se agarra como portada 
