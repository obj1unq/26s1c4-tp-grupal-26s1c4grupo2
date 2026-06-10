import wollok.game.*
import src.enemigoprueba.mapa.*

object player {
  var property position = game.at(1, 18)

  method image() = "byteman-abajo.png"

  method tryMove(dx, dy) {
    const nx = (position.x() + dx)
    const ny = (position.y() + dy)
    if (!mapaBuilder.isWallEn(nx, ny)) {
      position = game.at(nx, ny)
    }
  }

  method moveRight() { self.tryMove(1, 0) }
  method moveLeft()  { self.tryMove(-1, 0) }
  method moveUp()    { self.tryMove(0, 1) }
  method moveDown()  { self.tryMove(0, -1) }
}
