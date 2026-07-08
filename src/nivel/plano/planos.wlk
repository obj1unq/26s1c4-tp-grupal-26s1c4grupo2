import src.utilidades.inicializadores.*
import plano.Plano

const planoNivel1 = new Plano(
  matriz = [
    [k, k, k, k, k, k, k, k, k, k, k, k, k, k, k, k],
    [k, _, _, _, _, _, _, k, _, _, _, k, _, _, _, k],
    [k, _, m, m, _, m, _, k, _, i, _, k, _, h, _, k],
    [k, f, _, _, _, m, _, k, _, _, _, k, _, _, _, k],
    [k, _, m, m, _, m, _, k, k, k, _, k, k, k, l, k],
    [k, _, _, _, _, _, _, _, _, _, _, _, _, _, _, k],
    [k, k, k, k, k, k, k, k, k, k, k, k, k, k, _, k],
    [k, _, _, _, _, _, _, _, _, _, _, e, _, _, _, k],
    [k, k, k, _, k, k, k, g, k, k, k, k, k, k, k, k],
    [k, k, k, _, k, k, k, k, k, k, k, k, k, k, k, k],
    [k, _, _, _, _, _, _, _, _, _, _, _, _, _, _, k],
    [k, _, m, m, m, m, m, _, m, m, m, m, m, _, _, k],
    [k, _, _, _, _, _, _, d, _, _, _, _, _, _, _, k],
    [k, _, _, m, m, m, m, m, _, m, m, m, m, m, _, k],
    [k, a, _, _, _, _, _, _, _, _, _, _, _, _, _, k],
    [k, k, k, k, k, k, k, k, k, k, k, k, k, k, k, k]
  ].reverse()
)