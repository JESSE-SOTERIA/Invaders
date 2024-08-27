package main

import rl "vendor:raylib"

Spaceship :: struct {
	image:    rl.Texture2D,
	position: rl.Vector2,
}

new_spaceship :: proc() -> Spaceship {
	ship: Spaceship

	ship.image = rl.LoadTexture("graphics/invaders2/player.png")
	ship.position.x = 100
	ship.position.y = 100

	return ship
}

//make sure you call this function when the window is closed.
delete_spaceship :: proc(ship: ^Spaceship) {
	rl.UnloadTexture(ship.image)
}

Spaceship_draw :: proc(ship: ^Spaceship) {
	rl.DrawTextureV(ship.image, ship.position, rl.WHITE)
}

Spaceship_firelaser :: proc() {

}
