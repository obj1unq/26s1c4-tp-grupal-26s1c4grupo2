import wollok.game.*
import src.jugador.jugador.jugador

class Armario {
  const property position
  var estado = libre
  
  method image() = estado.image()
  
  method esAtravesable() = estado.esAtravesable()
  
  method ocupar() {
    estado = ocupado
  }
  
  method liberar() {
    estado = libre
  }
  
  method manejarColisionConJugador(jugador) {
    jugador.esconder(self)
    self.ocupar()
  }
}

object inicializadorArmario {
  method inicializar(nivel, x, y) {
    game.addVisual(new Armario(position = game.at(x, y)))
  }
} /* ESTADOS */

// Dependen de si ByteMan está dentro o fuera del Armario.

object libre {
  const property esAtravesable = true
  
  method image() = "armario-libre.png"
}

object ocupado {
  const property esAtravesable = false
  const property _jugador = jugador
  
  method image() = ("armario-ocupado-" + _jugador.orientacion().comoCadena()) + ".png"
}