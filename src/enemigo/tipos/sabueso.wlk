import wollok.game.*
import enemigo.Enemigo
import src.enemigo.comportamiento.movimiento.*
import src.enemigo.comportamiento.vision.*

class Sabueso inherits Enemigo (
  campoVision = new VisionSemicircular(radio = 5),
  movimiento = new Movimiento(estadoBase = patrullarAleatorio)
) {
  override method prefijoImagen() = "sabueso"
}

object inicializadorSabueso {
  method inicializar(nivel, x, y) {
    nivel.gestorEnemigos().agregar(new Sabueso(position = game.at(x, y)))
  }
}