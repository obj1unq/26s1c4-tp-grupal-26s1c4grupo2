import wollok.game.*

class Sabueso {
  var imagen = ""
  const property position
  
  method image() = imagen
  
  method manejarEstado(nuevoEstado) {
    nuevoEstado.afectar(self)
  }
  
  method establecerSigilo() {
    imagen = "sabueso-arriba-sigilo.png"
  }
  
  method establecerAlarma() {
    imagen = "sabueso-arriba-alarma.png"
  }
  
  method establecerReinicio() {
    imagen = "sabueso-arriba-reinicio.png"
  }
}

object inicializadorSabueso {
  method inicializar(nivel, x, y) {
    const sabueso = new Sabueso(position = game.at(x, y))
    sabueso.manejarEstado(nivel.estado())
    game.addVisual(sabueso)
  }
}