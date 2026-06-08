import wollok.game.*

class Muro {
  var imagen = ""
  const property position
  
  method image() = imagen
  
  method manejarEstado(nuevoEstado) {
    nuevoEstado.afectar(self)
  }
  
  method establecerSigilo() {
    imagen = "muro-sigilo.png"
  }
  
  method establecerAlarma() {
    imagen = "muro-alarma.png"
  }
  
  method establecerReinicio() {
    imagen = "muro-reinicio.png"
  }
}

object inicializadorMuro {
  method inicializar(nivel, x, y) {
    const muro = new Muro(position = game.at(x, y))
    muro.manejarEstado(nivel.estado())
    game.addVisual(muro)
  }
}