extends Node
const TRAINING_STAT:float=0.01
const EFECTIVE_ATTACK_MULTIPLICATOR:float=1.3
const EFECTIVE_ATTACK_MULTIPLICATOR_NOT:float=0.7
#const FIBONNACI_SEQUENCE:PackedInt64Array=[1,1,2,3,5,8]
func movement_speed(dir:Vector2,add:float,delta:float,impulse:float=1)->Vector2:return ((dir*impulse)*(10000+add))*delta
func probability_with_division(dividend:float,addend:float,second_dividend:float=3)->bool: return true if (dividend/(dividend+addend/second_dividend))<=randf() else false
func more_defend(_damage:float)->float:return (_damage*TRAINING_STAT)*TRAINING_STAT
func damage(_damage:float,sustractor:float,divisor:float)->float:return clampf((_damage*divisor)-sustractor*0.25,0.1,99999)
func knockback(_damage:float,life:float)->float:return clampf((_damage-(life/5))/2.0,0.0,999)
func average_2(v1:float,v2:float)->float:return (v1+v2)/2
func average(values:Array[float])->float:
	var a:float=0.0
	for i in values: a+=i
	return a/values.size()
