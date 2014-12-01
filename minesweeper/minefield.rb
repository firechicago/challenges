class Minefield
  attr_reader :row_count, :column_count

  def initialize(row_count, column_count, mine_count)
    @column_count = column_count
    @row_count = row_count
    @mines = []
    @cleared = []
    until @mines.length == mine_count
      row = rand(@row_count)
      col = rand(@column_count)
      @mines << { row: row, column: col } unless contains_mine?(row, col)
    end
  end

  # Return true if the cell been uncovered, false otherwise.
  def cell_cleared?(row, col)
    @cleared.include?({ row: row, column: col })
  end

  # Uncover the given cell. If there are no adjacent mines to this cell
  # it should also clear any adjacent cells as well. This is the action
  # when the player clicks on the cell.
  def clear(row, col)
    @cleared << { row: row, column: col }
    return @cleared unless adjacent_mines(row, col) == 0
    adjacent_cells(row, col).each do |cell|
      next if cell[:row] > row_count || cell[:row] < 0
      next if cell[:column] > column_count || cell[:column] < 0
      next if @cleared.include?(cell)
      clear(cell[:row], cell[:column])
    end
  end

  def adjacent_cells(row, col)
    result = []
    [-1, 0, 1].product([-1, 0, 1]).each do |point|
      result << {row: row + point[0], column: col + point[1]}
    end
    result.delete({row: row, column: col})
    result
  end

  # Check if any cells have been uncovered that also contained a mine. This is
  # the condition used to see if the player has lost the game.
  def any_mines_detonated?
    @mines.each do |mine|
      return true if cell_cleared?(mine[:row], mine[:column])
    end
    false
  end

  # Check if all cells that don't have mines have been uncovered. This is the
  # condition used to see if the player has won the game.
  def all_cells_cleared?
    (0..(row_count - 1)).each do |row|
      (0..(column_count - 1)).each do |column|
        cell = { row: row, column: column }
        return false unless @mines.include?(cell) || @cleared.include?(cell)
      end
    end
    true
  end

  # Returns the number of mines that are surrounding this cell (maximum of 8).
  def adjacent_mines(row, col)
    result = 0
    adjacent_cells(row, col).each do |cell|
      result += 1 if @mines.include?({ row: cell[:row], column: cell[:column] })
    end
    result
  end

  # Returns true if the given cell contains a mine, false otherwise.
  def contains_mine?(row, col)
    @mines.each do |mine|
      return true if mine[:row] == row && mine[:column] == col
    end
    false
  end
end
