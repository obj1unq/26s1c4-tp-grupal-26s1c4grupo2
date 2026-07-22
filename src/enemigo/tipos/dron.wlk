import wollok.game.*
import enemigo.Enemigo
import src.enemigo.comportamiento.movimiento.*
import src.enemigo.comportamiento.vision.*

class Dron inherits Enemigo (
  campoVision = new VisionSemicircular(radio = 4),
  movimiento = new Movimiento()
) {
  override method prefijoImagen() = "dron"

  override method puedeSerAlertado() = true
}

object inicializadorDron {
  method inicializar(nivel, x, y) {
    nivel.gestorEnemigos().agregar(new Dron(position = game.at(x, y), nivel = nivel))
  }
}