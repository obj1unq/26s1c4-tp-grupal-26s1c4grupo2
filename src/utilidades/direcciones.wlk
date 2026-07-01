class Direccion {
  method comoCadena()
  method siguiente(posicion)
  method dx()
  method dy()
  method rotar()
}

object arriba inherits Direccion {
  override method comoCadena() = "arriba"

  override method siguiente(posicion) = posicion.up(1)

  override method dx() = 0
  override method dy() = 1
  override method rotar() = izquierda
}
object derecha inherits Direccion {
  override method comoCadena() = "derecha"

  override method siguiente(posicion) = posicion.right(1)

  override method dx() = 1
  override method dy() = 0
  override method rotar() = arriba
}
object abajo inherits Direccion {
  override method comoCadena() = "abajo"

  override method siguiente(posicion) = posicion.down(1)

  override method dx() = 0
  override method dy() = -1
  override method rotar() = derecha
}
object izquierda inherits Direccion {
  override method comoCadena() = "izquierda"

  override method siguiente(posicion) = posicion.left(1)

  override method dx() = -1
  override method dy() = 0
  override method rotar() = abajo
}
