extends Node2D

var radius = 200
var nb_points = 100
var color = Color(0.5, 0.5, 0.5)

func _draw():
	draw_outline_circle(radius, color)
	
func draw_outline_circle(radius, color):
	var points_arc = PoolVector2Array()
	
	for i in range(nb_points + 1):
		var angle_point = deg2rad(i*360/nb_points)
		points_arc.push_back(Vector2(cos(angle_point), sin(angle_point)) * radius)
		
	for index_point in range(nb_points):
		if index_point % 2 ==0:
			draw_line(points_arc[index_point], points_arc[index_point + 1], color)
			
