import wollok.game.*

class PulsoElectroMagnetico {
  const property image = "pem.png"
  const property position
}

object inicializadorPEM {
  method inicializar(nivel, x, y) {
    game.addVisual(new PulsoElectroMagnetico(position = game.at(x, y)))
  }
}