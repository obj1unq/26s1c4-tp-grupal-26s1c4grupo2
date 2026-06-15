import wollok.game.*

class Muro {
  const property esAtravesable = false
  var imagen = ""
  const property position
  
  method image() = imagen
  
  method manejarEstado(nuevoEstado) {
    nuevoEstado.afectar(self)
  }
  
  method manejarSigilo() {
    imagen = "muro-sigilo.png"
  }
  
  method manejarAlarma() {
    imagen = "muro-alarma.png"
  }
  
  method manejarReinicio() {
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