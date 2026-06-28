class Direccion {
  method dx()
  method dy()
  method nombre()
  method siguiente()
}

object dirDerecha inherits Direccion {
  override method dx() = 1
  override method dy() = 0
  override method nombre() = "derecha"
  override method siguiente() = dirArriba
}

object dirArriba inherits Direccion {
  override method dx() = 0
  override method dy() = 1
  override method nombre() = "arriba"
  override method siguiente() = dirIzquierda
}

object dirIzquierda inherits Direccion {
  override method dx() = -1
  override method dy() = 0
  override method nombre() = "izquierda"
  override method siguiente() = dirAbajo
}

object dirAbajo inherits Direccion {
  override method dx() = 0
  override method dy() = -1
  override method nombre() = "abajo"
  override method siguiente() = dirDerecha
}
