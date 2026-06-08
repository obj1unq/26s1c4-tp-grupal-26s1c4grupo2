import wollok.game.*
import src.nivel.niveles.*

object juego {
  const niveles = [nivel1]
  
  method iniciar(nombre) {
    game.title(nombre)
    self.nivelInicial().inicializar()
    game.start()
  }
  
  method nivelInicial() = niveles.first()
}