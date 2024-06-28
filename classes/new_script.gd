class_name DigimonBodyMod extends DigimonBody
var hunger:int=0
func set_stats():
	core.max_hunger=hunger
	core.max_life=get_life()
	core.max_energy=get_energy()
	core.attribute=attribute
	core.Evo_level=Evo_level
	core.body=self
	if player:$sprite/Name.text=Iniload.player_name+"
	("+digimon_name+"mon)"
	else:$sprite/Name.text=digimon_name+"mon"
	$sprite/Name/VBoxContainer/e.set_mode()
	$sprite/Name/VBoxContainer/h.set_mode()
	$sprite/Name/VBoxContainer/l.set_mode()
