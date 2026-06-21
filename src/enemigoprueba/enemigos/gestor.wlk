import wollok.game.*
import src.enemigoprueba.enemigos.enemigo.*
import src.enemigoprueba.vision.vision.*
import src.enemigoprueba.movimiento.movimiento.*
import src.enemigoprueba.mapa.mapa.*

object gestorEnemigos {
  var enemigos   = []
  var pendientes = []
  var property maxEnemigos = 6

  method setup() {
    enemigos   = []
    pendientes = []

    const dron = new EnemigoDron(position=game.at(5, 2), campoVision=new VisionSemicircular(radio = 6), movimiento=new Movimiento())

    self.agregar(dron)

    const camara = new EnemigoCamara(position=game.at(10, 9), campoVision=new VisionLineal(rango = 6), movimiento=new Movimiento(estadoBase = new Rotar(), estado = new Rotar()))
    self.agregar(camara)

    const sabueso = new Sabueso(position=game.at(6, 4), campoVision=new VisionSemicircular(radio = 5), movimiento=new Movimiento(estadoBase = patrullarAleatorio, estado = patrullarAleatorio))
    self.agregar(sabueso)
  }

  method agregar(enemigo) {
    enemigos.add(enemigo)
    game.addVisual(enemigo)
  }


  method actualizar(objetivo) {
    enemigos.forEach({ e =>
      if (e.actualizar(objetivo)) self.invocarCerca()
    })
    pendientes.forEach({ e => self.agregar(e) })
    pendientes = []
  }

  method puedeInvocar() = (enemigos.size() + pendientes.size()) < maxEnemigos

  method invocarCerca() {
    if (self.puedeInvocar()) { 
        const nuevo = new Sabueso(position=game.at(11, 9), campoVision=new VisionSemicircular(radio = 5), movimiento=new Movimiento(estadoBase = patrullarAleatorio, estado = patrullarAleatorio))
        pendientes.add(nuevo)      
    }
  }

}
