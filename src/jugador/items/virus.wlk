import wollok.game.*

class Virus {
  const property image = "virus.png"
  const property position
}

object inicializadorVirus {
  method inicializar(nivel, x, y) {
    game.addVisual(new Virus(position = game.at(x, y)))
  }
}