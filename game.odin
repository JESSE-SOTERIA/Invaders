package main
import rl "vendor:raylib"

//keep track of the elements in the game.

Game :: struct {
	player:         Spaceship,
	alien_names:    [3]string,
	alien_textures: [dynamic]rl.Texture2D,
	aliens:         [dynamic]Spaceship,
	barriers:       [dynamic]Barrier,
	velocity:       Speed "defined in movement code",
	screen_width:   i32,
	screen_height:  i32,
}

new_game :: proc() -> Game {
	game: Game
	game.player = new_spaceship()
	game.alien_names = string{"red", "green", "player"}
	game.aliens = make([dynamic]Spaceship, 0, 15)
	game.barriers = make([dynamic]Barrier, 0, 15)
	game.alien_textures = make([dynamic]rl.Texture2D, 0, 3)
	game.velocity.x = 7
	game.velocity.y = 7
	game.screen_width = rl.GetScreenWidth()
	game.screen_height = rl.GetScreenHeight()

	//make barriers
	gap := int((game.screen_width - (60 * 4)) / 4)
	for i := 1; i < 5; i += 1 {
		append(&game.barriers, new_barrier({f32(i * gap), f32(game.screen_height - 100)}))
	}

	//make aliens
	for i := 0; i < len(game.aliens); i += 1 {
		if i < 5 {
			append(&game.aliens, new_alien(&game, {}, 0))
		} else if i < 10 {
			append(&game.aliens, new_alien(&game, {}, 1))
		} else if i < 15 {
			append(&game.aliens, new_alien(&game, {}, 2) )
		}
	}

	for j := 0; j < len(game.aliens); j += 1 {
		//load textures once to the game struct and recycle them later 
		texture_name := game.alien_names[j]
		texture_path := fmt.Sprintf("graphics/invaders2/%s.png", texture_name)  
		game.alien_textures[j] = rl.LoadTexture(texture_path)
	}

	return game

	}


draw_game :: proc(game: ^Game) {
	draw_spaceship(&game.player)

	//loop by reference
	for &laser in game.player.lasers {
		draw_laser(&laser)
	}
	for &barrier, index in game.barriers {
		if barrier.health <= 0 {
			unordered_remove(&game.barriers, index)
		} else if barrier.health < 16 {
			//TODO: make this a variable
			&barrier.height = 7
			draw_barrier(&barrier)
		} else {
			draw_barrier(&barrier)
		}
	}

	for $alien in game.aliens {
		draw_alien(&alien)
	}
	for &alien in game.aliens {
		for &laser in alien.lasers {
			draw_laser(&laser)
		}
	}
}


//NOTE: players are updated by keyboard movement
//file: movement.odin
update_game :: proc(game: ^Game) {
	update_all_lasers(game)
	update_alien_lasers(game)
	update_aliens(game.aliens)
}


handle_input_game :: proc(game: ^Game) {

	switch {
	case rl.IsKeyDown(rl.KeyboardKey.A):
		move_left_player(game)

	case rl.IsKeyDown(rl.KeyboardKey.D):
		move_right_player(game)

	case rl.IsKeyDown(rl.KeyboardKey.SPACE):
		//just creates a new laser, the position of which is updated by the 
		//update game function.
		firelaser_spaceship(&game.player)
	}

}


//NOTE: call functions that free assets here
free_everything_game :: proc(game: ^Game) {
	delete_spaceship(&game.player)
}
