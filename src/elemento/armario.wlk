import wollok.game.*

class Armario {
  var property image = "armario.png"
  const property position
}

object inicializadorArmario {
  method inicializar(nivel, x, y) {
    game.addVisual(new Armario(position = game.at(x, y)))
  }
}