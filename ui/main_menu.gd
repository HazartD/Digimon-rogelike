extends Control
const seed_preview:PackedStringArray=["NS","IS","SS"]
func _on_button_button_down():
	if $TextEdit.text=="":
		print("nulo")
		randomize()
		Iniload.seed_string=""
		Iniload.actual_seed=randi()
	elif $TextEdit.text.is_valid_int():
		print("se ingreso un int")
		Iniload.seed_string=""
		Iniload.actual_seed=int($TextEdit.text)
	else:
		print("habia texto, se uso hash")
		Iniload.actual_seed=hash($TextEdit.text)
		Iniload.seed_string=$TextEdit.text
	var rng=RandomNumberGenerator.new()
	rng.seed=Iniload.actual_seed
	for an in 1:for al in 3:Iniload.world_seed[Vector2(an,al)]=[rng.randi()]
	for map in Iniload.world_seed.keys():
		#aqui debe comprobar latitud y logitud (paralelo X,meridiano Y,) y hechar a suerte en donde poner cada uno segun la location que tenga
		#tambien debo poner en el menu una imagen tipo "mapa actul" y es una imagen del metal encima del nature encima del deep, luego "lo planeado" y sea ya algo mas complejo con todos los field. Puedo poner un boton que los ordene al azar para practicar la logica de que decida ya encerio 
		#debo poner que el tile comprube la ubicacion, 
		if map.y==0:Iniload.world_seed[map]+=[Iniload.LOCATIONS.CRACK_TEAM_BASE]
		if map.y==1:Iniload.world_seed[map]+=[Iniload.LOCATIONS.FILE_CITY]
		if map.y==2:Iniload.world_seed[map]+=[Iniload.LOCATIONS.SHORE]
	Iniload.create_seed_regiser_file()


func _on_text_edit_text_changed():
	print("cambio texto")
	if $TextEdit.text=="":$Button/Label.text=seed_preview[0]# if$Button/Label.text!=seed_preview[0]:
	elif $TextEdit.text.is_valid_int():$Button/Label.text=seed_preview[1]
	else:$Button/Label.text=seed_preview[2]
