package main
import "core:fmt"
import rl "vendor:raylib"


Barrier :: struct {
	position: rl.Vector2,
	width:    i32,
	height:   i32,
	health:   i32,
	hitbox:   rl.Rectangle,
}

new_barrier :: proc(position: rl.Vector2) -> Barrier {

	barrier: Barrier
	barrier.position = position
	barrier.width = 60
	barrier.height = 14
	barrier.health = 30
	barrier.hitbox = rl.Rectangle {
		barrier.position.x,
		barrier.position.y,
		f32(barrier.width),
		f32(barrier.height),
	}

	return barrier
}


draw_barrier :: proc(barrier: ^Barrier) {
	if barrier.health <= 0 {
		return
	} else {
		rl.DrawRectangle(
			i32(barrier.position.x),
			i32(barrier.position.y),
			barrier.width,
			barrier.height,
			rl.YELLOW,
		)
		rl.DrawRectangle(
			i32(barrier.hitbox.x),
			i32(barrier.hitbox.y),
			i32(barrier.hitbox.width),
			i32(barrier.height),
			{255, 255, 255, 0},
		)
	}
}

