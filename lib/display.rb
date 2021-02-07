# frozen_string_literal: true

# Displays text
module Display
  # rubocop: disable Metrics/AbcSize
  def display_board(board_state)
    chars = board_state.map { |space| space.nil? ? ' ' : space.to_s }
    puts <<-HEREDOC
       A   B   C   D   E   F   G   H
     ┌───┬───┬───┬───┬───┬───┬───┬───┐
    8│ #{chars[0]} │ #{chars[1]} │ #{chars[2]} │ #{chars[3]} │ #{chars[4]} │ #{chars[5]} │ #{chars[6]} │ #{chars[7]} │
     ├───┼───┼───┼───┼───┼───┼───┼───┤
    7│ #{chars[8]} │ #{chars[9]} │ #{chars[10]} │ #{chars[11]} │ #{chars[12]} │ #{chars[13]} │ #{chars[14]} │ #{chars[15]} │
     ├───┼───┼───┼───┼───┼───┼───┼───┤
    6│ #{chars[16]} │ #{chars[17]} │ #{chars[18]} │ #{chars[19]} │ #{chars[20]} │ #{chars[21]} │ #{chars[22]} │ #{chars[23]} │
     ├───┼───┼───┼───┼───┼───┼───┼───┤
    5│ #{chars[24]} │ #{chars[25]} │ #{chars[26]} │ #{chars[27]} │ #{chars[28]} │ #{chars[29]} │ #{chars[30]} │ #{chars[31]} │
     ├───┼───┼───┼───┼───┼───┼───┼───┤
    4│ #{chars[32]} │ #{chars[33]} │ #{chars[34]} │ #{chars[35]} │ #{chars[36]} │ #{chars[37]} │ #{chars[38]} │ #{chars[39]} │
     ├───┼───┼───┼───┼───┼───┼───┼───┤
    3│ #{chars[40]} │ #{chars[41]} │ #{chars[42]} │ #{chars[43]} │ #{chars[44]} │ #{chars[45]} │ #{chars[46]} │ #{chars[47]} │
     ├───┼───┼───┼───┼───┼───┼───┼───┤
    2│ #{chars[48]} │ #{chars[49]} │ #{chars[50]} │ #{chars[51]} │ #{chars[52]} │ #{chars[53]} │ #{chars[54]} │ #{chars[55]} │
     ├───┼───┼───┼───┼───┼───┼───┼───┤
    1│ #{chars[56]} │ #{chars[57]} │ #{chars[58]} │ #{chars[59]} │ #{chars[60]} │ #{chars[61]} │ #{chars[62]} │ #{chars[63]} │
     └───┴───┴───┴───┴───┴───┴───┴───┘
    HEREDOC
  end
  # rubocop: enable Metrics/AbcSize

  def display_promotion_options
    puts <<~HEREDOC
      Your pawn has reached the back row. Enter a number to choose what to promote to:
      1. Queen
      2. Knight
      3. Rook
      4. Bishop
    HEREDOC
  end

  def display_input_prompt
    puts <<~HEREDOC
      Input start and end coordinates space separated. Example: 'A2 A4'
      You may also save your game by typing 'Save'. All inputs are case insensitive.
    HEREDOC
  end

  def display_checkmate(loser, winner)
    puts "#{loser.capitalize} is in checkmate. #{winner.capitalize} has won. Congratz!"
  end

  def display_stalemate(color)
    puts "#{color.capitalize} has no legal moves yet is not in check. Stalemate. This game is a draw."
  end

  def display_turn(color, check)
    puts "#{color.capitalize}'s turn to make a move."
    puts "#{color.capitalize} is in check" if check == true
  end

  def display_save_success(file_name)
    puts "Your game was successfully saved as #{file_name}"
    puts 'Thank you for playing!'
  end

  def display_save_select(hash)
    puts 'Enter the number of the save you would like to select'
    hash.each { |k, v| puts "#{k} - #{v}" }
  end

  def display_mode_prompt
    puts 'Would you like to start a new game, load a previous game?'
    puts '1 - Start a new game'
    puts '2 - Load a game'
  end

  def display_invalid_input
    puts 'Invalid input.'
  end
end
