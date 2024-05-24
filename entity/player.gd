class_name Player extends DigimonCORE
var data:Array[float]=[]
var alive:bool=true
var line_id:Array[int]=[0,16,3]
func _ready():
	var plus=Iniload.statsplus
	for i in plus.keys(): set(i,plus[i])

func dead(cause):
	var save_data={
	"time":time,
	"player_name":Iniload.player_name,
	"digimon_id":digimon_id,
	"line_id":line_id,
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
	#alive=false

func hit(damage:float,dir:Vector2,a:DigimonBody,physic:bool,pasive:bool=false):
	body.dir=dir
	if pasive:_hit(damage,dir,a.attribute,physic)
	else:
		var limit=(body.get_speed()-a.get_speed())/2
		print(limit)
		if randi_range(0,limit)==0:_hit(damage,dir,a.attribute,physic)
		else:print(self.name," evadio")
#	if current_life<=0: dead(a.Digimon_Id)



func _on_tree_exiting():
	pass
#	if alive:dead("exit game")
	
func _process(delta):
	time+=delta



func _on_child_entered_tree(node):
	if node is DigimonBody:
		line_id.append(node.Digimon_Id)
		node.player=true
