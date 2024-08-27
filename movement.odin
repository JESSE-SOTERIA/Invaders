package main

Speed :: struct {
	x: f32,
	y: f32,
}

move_left_player :: proc(game: ^Game) {
	game.player.position.x -= game.velocity.x

	//limit the player to the screen boundaries.
	if (game.player.position.x < 0) {
		game.player.position.x = 0
	}
}

move_right_player :: proc(game: ^Game) {
	game.player.position.x += game.velocity.x

	//limit the player to screen boundaries.
	if (i32(game.player.position.x) > (game.screen_width - game.player.image.width)) {
		game.player.position.x = f32(game.screen_width - game.player.image.width)
	}
}
