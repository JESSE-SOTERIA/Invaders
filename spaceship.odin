package main

import rl "vendor:raylib"
import "core:runtime"

Spaceship :: struct {
	image:    rl.Texture2D,
	position: rl.Vector2,
	lasers: [dynamic]Laser,
}

new_spaceship :: proc() -> Spaceship {
	ship: Spaceship
	lasers := make([dynamic]Laser, 1)

	ship.image = rl.LoadTexture("graphics/invaders2/player.png")
	ship.position.x = f32((rl.GetScreenWidth() - ship.image.width) / 2)
	ship.position.y = f32(rl.GetScreenHeight() - ship.image.height)
	ship.lasers = lasers

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
	laser := new_laser({(ship.position.x + f32(ship.image.width / 2) -2), ship.position.y}, -6 )
	runtime.append_elem(&ship.lasers, laser)
}
