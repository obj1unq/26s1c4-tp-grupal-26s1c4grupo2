object arriba {
  method comoCadena() = "arriba"

  method siguiente(posicion) = posicion.up(1)
}
object derecha {
  method comoCadena() = "derecha"

  method siguiente(posicion) = posicion.right(1)
}
object abajo {
  method comoCadena() = "abajo"

  method siguiente(posicion) = posicion.down(1)
}
object izquierda {
  method comoCadena() = "izquierda"

  method siguiente(posicion) = posicion.left(1)
}