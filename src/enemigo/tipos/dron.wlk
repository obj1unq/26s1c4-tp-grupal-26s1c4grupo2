import wollok.game.*
import enemigo.Enemigo
import src.enemigo.comportamiento.movimiento.*
import src.enemigo.comportamiento.vision.*

class Dron inherits Enemigo (
  campoVision = new VisionSemicircular(radio = 6),
  movimiento = new Movimiento()
) {
  override method prefijoImagen() = "dron"
}

object inicializadorDron {
  method inicializar(nivel, x, y) {
    nivel.gestorEnemigos().agregar(new Dron(position = game.at(x, y)))
  }
}