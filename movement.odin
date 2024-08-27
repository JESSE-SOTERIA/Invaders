package main

move_left_player :: proc(game: ^Game) {
	game.player.position.x -= 7
}

move_right_player :: proc(game: ^Game) {
	game.player.position.x += 7
}
