package main

import rl "vendor:raylib"
import "core:runtime"
import "core:time"
import "core:fmt"

Spaceship :: struct {
	image:    rl.Texture2D,
	position: rl.Vector2,
	lasers: [dynamic]Laser,
	stopwatch: time.Stopwatch,
	fire_constraint: time.Duration,
}

new_spaceship :: proc() -> Spaceship {
	ship: Spaceship
	lasers := make([dynamic]Laser, 1)

	ship.image = rl.LoadTexture("graphics/invaders2/player.png")
	ship.position.x = f32((rl.GetScreenWidth() - ship.image.width) / 2)
	ship.position.y = f32(rl.GetScreenHeight() - ship.image.height)
	ship.lasers = lasers
	ship.fire_constraint = (150 * time.Millisecond)
	time.stopwatch_start(&ship.stopwatch)

	return ship
}

//make sure you call this function when the window is closed.
delete_spaceship :: proc(ship: ^Spaceship) {
	rl.UnloadTexture(ship.image)
}

draw_spaceship :: proc(ship: ^Spaceship) {
	rl.DrawTextureV(ship.image, ship.position, rl.WHITE)
}

firelaser_spaceship :: proc(ship: ^Spaceship ) {
	if time.stopwatch_duration(ship.stopwatch) < ship.fire_constraint {
		return
	} else {
		laser := new_laser({(ship.position.x + f32(ship.image.width / 2) -2), ship.position.y}, -6 )
		runtime.append_elem(&ship.lasers, laser)
		time.stopwatch_reset(&ship.stopwatch)
		time.stopwatch_start(&ship.stopwatch)
	}
}
