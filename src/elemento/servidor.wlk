import wollok.game.*

class Servidor {
  var imagen = ""
  const property position
  
  method image() = imagen
  
  method manejarEstado(nuevoEstado) {
    nuevoEstado.afectar(self)
  }
  
  method establecerSigilo() {
    imagen = "servidor-sigilo.png"
  }
  
  method establecerAlarma() {
    imagen = "servidor-alarma.png"
  }
  
  method establecerReinicio() {
    imagen = "servidor-reinicio.png"
  }
}

object inicializadorServidor {
  method inicializar(nivel, x, y) {
    const servidor = new Servidor(position = game.at(x, y))
    servidor.manejarEstado(nivel.estado())
    game.addVisual(servidor)
  }
}