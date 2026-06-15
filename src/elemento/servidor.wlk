import wollok.game.*

class Servidor {
  const property esAtravesable = false
  var imagen = ""
  const property position
  
  method image() = imagen
  
  method manejarEstado(nuevoEstado) {
    nuevoEstado.afectar(self)
  }
  
  method manejarSigilo() {
    imagen = "servidor-sigilo.png"
  }
  
  method manejarAlarma() {
    imagen = "servidor-alarma.png"
  }
  
  method manejarReinicio() {
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