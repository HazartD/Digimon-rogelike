class_name Player extends DigimonCORE
var data:Array[float]=[]
var player_name:String
var alive:bool=true
#const BODY=preload("res://entity/digimon_base.tscn")

func _ready():
	var plus=Iniload.statsplus
	for i in plus.keys(): set(i,plus[i])
	#var chil=BODY.instantiate()
	#add_child(chil)
	#body=chil
#	dead("test")
#	print(life)
func _input(event):
	if event.is_action_pressed("screenshot"):
		var path="user://HazartD/DR/screenshot/ss%i.png"
		var _imagen=get_viewport().get_texture().get_image().save_png(path)
		
func dead(cause):
	var save_data={
	"time":time,
	"player_name":player_name,
	"digimon_id":digimon_id,
	"life":life,
	"energy":energy,
	"attack":attack,
	"defend":defend,
	"speed":speed,
	"inteligent":inteligent,
	"will":will,
	"fighter":fighter,
	"dead cause":cause}
	Iniload.savedead(save_data)
	alive=false

func hit(damage:float,dir:Vector2,a:DigimonCORE):
	_hit(damage,dir)
	if current_life<=0: dead(a.Digimon_Id)



func _on_tree_exiting():
	if alive:dead("quit game")
	
func _process(delta):
	time+=delta

