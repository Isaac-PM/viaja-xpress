import Control.Monad (void)
import Grafo (Camino (..), caminoMasCorto, cargarGrafo)
import Lugar (devolverLugares)

main :: IO ()
main = do
  putStr "\ESC[2J"
  putStrLn ""
  putStrLn ">>>>>>>>> Bienvenid@ a la agencia ViajaXpress <<<<<<<<<"
  putStrLn "Ofrecemos los mejores destinos a los mejores precios."
  putStrLn ""
  putStrLn "Planifique su viaje, ingrese la ubicacion de salida y de llegada."
  putStrLn ">>>>>>>>> Nuestros destinos <<<<<<<<<"
  devolverLugares
  putStrLn "(SS) Salir"
  putStrLn ""
  putStrLn "Ingrese la ubicacion de salida: "
  salida <- getLine
  if salida /= "SS"
    then do
      putStrLn "Ingrese la ubicacion de llegada: "
      llegada <- getLine
      if llegada /= "SS"
        then do
          grafo <- cargarGrafo "../data/grafo.txt"
          let camino = caminoMasCorto salida llegada grafo
          case camino of
            Nothing -> putStrLn "No existe un camino entre los lugares ingresados."
            Just camino -> do
              putStrLn ""
              putStrLn "El camino mas corto es: "
              print (reverse (recorrido camino))
              putStrLn ""
              putStrLn "El costo del viaje (en $) es: "
              print (pesoAcumulado camino * 50)
              putStrLn ""
              putStrLn "Gracias por elegirnos, esperamos que disfrute su viaje."
              putStrLn "Presione enter para continuar."
              void getLine
              main
        else putStrLn "Gracias por elegirnos, esperamos que disfrute su viaje.\n"
    else putStrLn "Gracias por elegirnos, esperamos que disfrute su viaje.\n"
