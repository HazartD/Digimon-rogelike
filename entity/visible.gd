extends VisibleOnScreenNotifier2D
var body:DigimonBody
func _process(_delta)->void:if body:global_position=body.global_position
func _draw()->void:draw_rect(get_rect(), Color(1, 0, 0,0.5), true)
