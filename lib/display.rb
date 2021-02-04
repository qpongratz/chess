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
end
