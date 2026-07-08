import wollok.game.*
import enemigo.Enemigo
import src.enemigo.comportamiento.movimiento.*
import src.enemigo.comportamiento.vision.*

class Camara inherits Enemigo (
  esAtravesable = false,
  campoVision = new VisionLineal(rango = 4),
  movimiento = new Movimiento(estadoBase = new Rotar())
) {
  override method prefijoImagen() = "camara"
  
  override method detectarObjetivo(objetivo) {
    if (self.puedeDetectar(objetivo)) self.manejarAlarma()
    else self.manejarSigilo()
  }

  override method reaccionar(objetivo) = self.puedeDetectar(objetivo)
  
  override method alContacto(objetivo) {

  }
}

object inicializadorCamara {
  method inicializar(nivel, x, y) {
    nivel.gestorEnemigos().agregar(new Camara(position = game.at(x, y)))
  }
}