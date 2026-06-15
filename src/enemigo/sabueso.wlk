import wollok.game.*
import src.utilidades.direcciones.*

class Sabueso {
  const property esAtravesable = true
  var orientacion = arriba
  const property position
  var estadoDeImagen = ""
  
  method image() = ((("sabueso-" + orientacion.comoCadena()) + "-") + estadoDeImagen) + ".png"
  
  method manejarEstado(nuevoEstado) {
    nuevoEstado.afectar(self)
  }
  
  method manejarSigilo() {
    estadoDeImagen = "sigilo"
  }
  
  method manejarAlarma() {
    estadoDeImagen = "alarma"
  }
  
  method manejarReinicio() {
    estadoDeImagen = "reinicio"
  }
}

object inicializadorSabueso {
  method inicializar(nivel, x, y) {
    const sabueso = new Sabueso(position = game.at(x, y))
    sabueso.manejarEstado(nivel.estado())
    game.addVisual(sabueso)
  }
}