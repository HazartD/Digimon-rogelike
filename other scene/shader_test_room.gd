extends Node2D
func _ready():
	randomize()
	#print("tenes el doble ",(10.0/(10+20.0))/4)
	#print("tenes poco mas ",(10.0/(10+11.0))/4)
	#print("tienen lo mismo ",(10.0/(10+10.0))/4)
	#print("tienes pcoo menos ",(10.0/(10+9.0))/4)
	#print("tienes la mitad ",(10.0/(10+5.0))/4)
	#print("tienes bastante menos ",(10.0/(10+1.0))/4)
	#var resul_doble:Dictionary={true:0,false:0}
	#for i in 1000:
		#if (10.0/(10+20.0))/4<=randf():resul_doble[true]+=1
		#else:resul_doble[false]+=1
	#print("doble ",resul_doble)
	#var resul_equal:Dictionary={true:0,false:0}
	#for i in 1000:
		#if (10.0/(10+10.0))/4<=randf():resul_equal[true]+=1
		#else:resul_equal[false]+=1
	#print("igual ",resul_equal)
	#var resul_mitad:Dictionary={true:0,false:0}
	#for i in 1000:
		#if (10.0/(10+5.0))/4<=randf():resul_mitad[true]+=1
		#else:resul_mitad[false]+=1
	#print("mitad ",resul_mitad)
	var resul:Dictionary={true:0,false:0}
	for i in 100:
		if 10.0/(100)>=randf():resul[true]+=1
		else:resul[false]+=1
	print(resul)
	#await get_tree().create_timer(1).timeout
	#var tween=get_tree().create_tween()
	#tween.tween_property($Sprite2D.material,"shader_parameter/progress",1,0.3)
