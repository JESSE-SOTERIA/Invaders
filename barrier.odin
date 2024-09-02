package main
import rl "vendor:raylib"


Barrier :: struct {
	position: rl.Vector2,
	width:    i32,
	height:   i32,
	health:   i32,
}

new_barrier :: proc(position: rl.Vector2) -> Barrier {

	barrier: Barrier
	barrier.position = position
	barrier.width = 30
	barrier.height = 7
	barrier.health = 10

	return barrier
}


draw_barrier :: proc(barrier: Barrier) {
	if barrier.health == 0 {
		delete_barrier(barrier)
		return
	} else {
		rl.DrawRectangle(
			i32(barrier.position.x),
			i32(barrier.position.y),
			barrier.width,
			barrier.height,
			rl.YELLOW,
		)
	}
}

update_barrier :: proc(barrier: Barrier) {

	if barrier.health == 0 {
		delete_barrier(barrier)
	}
}

delete_barrier :: proc(barrier: Barrier) {

}
