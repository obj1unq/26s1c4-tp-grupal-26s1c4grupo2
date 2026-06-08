import wollok.game.*

class Dron {
  var imagen = ""
  const property position
  
  method image() = imagen
  
  method manejarEstado(nuevoEstado) {
    nuevoEstado.afectar(self)
  }
  
  method establecerSigilo() {
    imagen = "dron-izquierda-sigilo.png"
  }
  
  method establecerAlarma() {
    imagen = "dron-izquierda-alarma.png"
  }
  
  method establecerReinicio() {
    imagen = "dron-izquierda-reinicio.png"
  }
}

object inicializadorDron {
  method inicializar(nivel, x, y) {
    const dron = new Dron(position = game.at(x, y))
    dron.manejarEstado(nivel.estado())
    game.addVisual(dron)
  }
}