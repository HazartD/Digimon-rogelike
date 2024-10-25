extends StateDigimon
#var progress:float=0.0
func start()->void:
	digimon.dir=Vector2i.ZERO
	var frelear=[get_node_or_null("patas"),get_node_or_null("prepcion"),get_node_or_null("sprite/Name")]
	for i in frelear:if i:i.queue_free()
	digimon.sprite.material.shader=Resouses.DEAD
	digimon.sprite.material.shader.set("resource_local_to_scene",true)
	match digimon.attribute:
		DigimonCORE.attribut.VI: digimon.sprite.material.set("shader_parameter/color",Vector3(1,0,0))#Color(1,0,0)
		DigimonCORE.attribut.VA: digimon.sprite.material.set("shader_parameter/color",Vector3(0,0,1))#Color(0,0,1)
		DigimonCORE.attribut.DA: digimon.sprite.material.set("shader_parameter/color",Vector3(0,1,1))#Color(0,1,1)
		DigimonCORE.attribut.FR: digimon.sprite.material.set("shader_parameter/color",Vector3(2,2,2))#Color(0,1,1)
		_:digimon.sprite.material.set("shader_parameter/color",Vector3(0.14,0.14,0.14))#Color(0.14,0.14,0.14,1)
	digimon.sprite.material.set("shader_parameter/progress",0.001)
func on_process(delta)->void:
	var progress=digimon.sprite.material.get("shader_parameter/progress")
	if progress:digimon.sprite.material.set("shader_parameter/progress",progress+delta/5)
func end()->void:for body in digimon.enemies:if body:body.core.data+=int(digimon.get_life()/digimon.enemies.size()*2)
