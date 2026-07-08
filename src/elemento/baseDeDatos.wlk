import wollok.game.*

class BaseDeDatos {
  const property esAtravesable = true 
  const property position
  const nivel
  var imagen = "base-de-datos.png"
  
  method image() = imagen
  
  method manejarColisionConJugador(jugador) {
    self.llevar()
  }
  
  method llevar() {
    imagen = "base-de-datos-llevada.png"
    game.schedule(500, { nivel.ganar() })
  }
}

object inicializadorBaseDeDatos {
  method inicializar(_nivel, x, y) {
    game.addVisual(new BaseDeDatos(position = game.at(x, y), nivel = _nivel))
  }
}