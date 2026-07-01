import wollok.game.*
import src.utilidades.tablero.tablero

object utils {
  method signo(valor) {
    if (valor > 0) {
      return 1
    }
    if (valor < 0) {
      return -1
    }
    return 0
  }
  
  method lineaDespejada(desde, hasta) {
    const dx = hasta.x() - desde.x()
    const dy = hasta.y() - desde.y()
    const pasos = dx.abs().max(dy.abs())
    
    if (pasos <= 1) {
      return true
    }
    
    return (1 .. (pasos - 1)).all(
      { paso =>
        const cx = desde.x() + (dx * paso).div(pasos)
        const cy = desde.y() + (dy * paso).div(pasos)
        return tablero.elementosEnCelda(game.at(cx, cy)).all(
          { e => e.esAtravesable() }
        )
      }
    )
  }
}