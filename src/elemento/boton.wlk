import wollok.game.*

class Boton {
  const property image = "boton.png"
  const property position
}

object inicializadorBoton {
  method inicializar(nivel, x, y) {
    game.addVisual(new Boton(position = game.at(x, y)))
  }
}