require 'byebug'

class MazeUnit

  def initialize(char)
    @parent = nil
    @char = char
  end

  attr_accessor :char, :parent
end

def loadMaze(file)
  maze = []
  mazelines = File.readlines(file)

  width = mazelines[0].length
  height = mazelines.length

  start_point = -1
  end_point = -1

  mazelines.each do |line|
    line.split(//).each do |char|
      maze.push(MazeUnit.new(char))
      start_point = maze.length - 1 if char == "S"
      end_point = maze.length - 1 if char == "E"
    end
  end

  return maze, start_point, end_point, width, height
end

def checkPoint(point)
  point.parent == nil and ['E',' '].include?(point.char)
end


def fillMaze(maze, start_point, width)
  proc_queue = [start_point]
  while current_point = proc_queue.shift
    [-1, 1, -width, width].each do |direction|
      new_point = current_point + direction
      if checkPoint(maze[new_point])
        proc_queue.push(new_point)
        maze[new_point].parent = current_point
      end
    end
  end
end

def printSolution(maze, end_point, width, height)
  current_point = end_point
  while current_point = maze[current_point].parent
    maze[current_point].char = "X" unless maze[current_point].char == "S"
  end
  (0..height).each do |line|
    puts maze[line * width, width].map { |mazeunit| mazeunit.char }.join("")
  end
end

def solveMaze(file)
  maze, start_point, end_point, width, height = loadMaze(file)
  fillMaze(maze, start_point, width)
  printSolution(maze, end_point, width, height)
end
