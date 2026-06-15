import wollok.game.*

class BaseDeDatos {
  const property esAtravesable = true 
  const property image = "base-de-datos.png"
  const property position
}

object inicializadorBaseDeDatos {
  method inicializar(nivel, x, y) {
    game.addVisual(new BaseDeDatos(position = game.at(x, y)))
  }
}