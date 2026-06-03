import wollok.game.*

object player {
  var property position = game.center()
  
  method image() = "byteman-arriba.png"
  
  method position() = position
  
  method mover(nuevaPosicion) {
    if (self.estaDentroDelTablero(nuevaPosicion)) {
      position = nuevaPosicion
    }
  }
  
  method estaDentroDelTablero(nuevaPos) = nuevaPos.x().between(
    0,
    game.width() - 1
  ) && nuevaPos.y().between(0, game.height() - 1)
}