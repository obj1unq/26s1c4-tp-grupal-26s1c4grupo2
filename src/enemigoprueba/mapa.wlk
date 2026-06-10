import wollok.game.*

class Wall {
  const property position
  method image() = "muro-alarma.png"
}

object mapaBuilder {
  var property wallPositions = []
  var property wallDict      = new Dictionary()  // "x-y" -> true

  var property mazeLayout = [
    "####################",
    "#P.................#",
    "#.####.######.###.#",
    "#.#....#......#...#",
    "#.#.##.#.####.#.#.#",
    "#.#.#..#.#....#.#.#",
    "#.#.#..#.#.####.#.#",
    "#...#..#.#......#.#",
    "###.#..#.########.#",
    "#...#.............#",
    "#.###.###########.#",
    "#.#...#...........#",
    "#.#.###.#########.#",
    "#.#.....#.........#",
    "#.#######.#######.#",
    "#.........#.......#",
    "#.#########.#####.#",
    "#.#.........#.....#",
    "#...#########.###.#",
    "####################"
  ]

  // Clave entera de una celda (rápida: sin construir strings).
  method clave(x, y) {
    return (x * 20) + y
  }


  method isWallEn(x, y) {
    if (x < 0 || x > 19 || y < 0 || y > 19) return true
    return wallDict.containsKey(self.clave(x, y))
  }

  // Compatibilidad: chequeo a partir de una Position.
  method isWall(pos) {
    return self.isWallEn(pos.x(), pos.y())
  }

  method setup() {
    const rows = mazeLayout.size()
    (0..(rows - 1)).forEach({ rowIdx =>
      const row = mazeLayout.get(rowIdx)
      const wollokY = (rows - 1 - rowIdx)
      (0..(row.size() - 1)).forEach({ colIndex =>
        if (row.charAt(colIndex) == "#") {
          const pos = game.at(colIndex, wollokY)
          wallPositions.add(pos)
          wallDict.put(self.clave(colIndex, wollokY), true)
          game.addVisual(new Wall(position = pos))
        }
      })
    })
  }
}
