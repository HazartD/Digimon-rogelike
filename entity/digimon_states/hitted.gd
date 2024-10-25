extends StateDigimon
var last_state:String
func start()->void:
	digimon.dir=Vector2i.ZERO
	digimon.sprite.play("hit_"+digimon.sprite.animation.erase(0,4))
	digimon.hurt.play()
	await digimon.sprite.animation_finished
	if !state_machine.special:state_machine.change_state(last_state)
