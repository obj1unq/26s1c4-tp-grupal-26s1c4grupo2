import wollok.game.*
import src.utilidades.tablero.tablero
import src.utilidades.direcciones.*
import src.enemigo.tipos.sabueso.*

class GestorEnemigos {
  var enemigos = []
  var pendientes = []
  var property maxEnemigos = 6
  var property estado = null
  const nivel
  
  method limpiar() {
    enemigos = []
    pendientes = []
  }

  method agregar(enemigo) {
    if (estado !== null) enemigo.manejarEstado(estado)
    enemigos.add(enemigo)
    game.addVisual(enemigo)
  }
  
  method actualizar(objetivo) {
    enemigos.forEach(
      { e =>
        if (e.reaccionar(objetivo)) self.invocarCerca(e.position())
        return e.actualizar(objetivo)
      }
    )
    pendientes.forEach({ e => self.agregar(e) })
    pendientes = []
  }
  
  method alertarCercaDe(posicion, rango) {
    const candidatos = enemigos.filter(
      { e => e.puedeSerAlertado() && (e.position().distance(posicion) <= rango) }
    )
    if (!candidatos.isEmpty())
      candidatos.min({ e => e.position().distance(posicion) }).alertar(posicion)
  }

  method puedeInvocar() = (enemigos.size() + pendientes.size()) < maxEnemigos
  
  method invocarCerca(posicion) {
    if (self.puedeInvocar()) {
      const destino = self.celdaLibreCercaDe(posicion)
      if (destino !== null) pendientes.add(new Sabueso(position = destino, nivel = nivel))
    }
  }
  
  method celdaLibreCercaDe(posicion) {
    const libres = [derecha, arriba, izquierda, abajo].map(
      { dir => dir.siguiente(posicion) }
    ).filter({ pos => self.esValida(pos) })
    return if (libres.isEmpty()) null else libres.first()
  }
  
  method esValida(posicion) = tablero.elementosEnCelda(posicion).all(
    { e => e.esAtravesable() }
  )
}