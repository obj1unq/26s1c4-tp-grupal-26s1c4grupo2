import wollok.game.*

class Puerta {
  var property image = "puerta.png"
  const property position
}

object inicializadorPuerta {
  method inicializar(nivel, x, y) {
    game.addVisual(new Puerta(position = game.at(x, y)))
  }
}