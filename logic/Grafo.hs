module Grafo where

import Data.List (minimumBy)
import Data.Maybe (fromJust, isJust)
import Data.Ord (comparing)
import System.Environment

splitOn :: Char -> String -> [String]
splitOn _ [] = []
splitOn c s = [x] ++ splitOn c (drop 1 y)
  where
    (x, y) = span (/= c) s

data Nodo = Nodo
  { nombre :: String,
    destinos :: [Arco]
  }
  deriving (Show, Eq, Ord)

data Arco = Arco
  { destino :: String,
    peso :: Int
  }
  deriving (Show, Eq, Ord)

data Grafo = Grafo
  { nodos :: [Nodo]
  }
  deriving (Show, Eq, Ord)

data Camino = Camino
  { recorrido :: [String],
    pesoAcumulado :: Int
  }
  deriving (Show, Eq, Ord)

construirNodo :: String -> [Arco] -> Nodo
construirNodo = Nodo

construirArco :: String -> Int -> Arco
construirArco = Arco

construirGrafo :: [Nodo] -> Grafo
construirGrafo = Grafo

agregarNodo :: Nodo -> Grafo -> Grafo
agregarNodo nodo grafo = construirGrafo (nodo : nodos grafo)

buscarNodo :: String -> Grafo -> Maybe Nodo
buscarNodo nombreBuscar grafo = case filter (\nodo -> nombreBuscar == nombre nodo) (nodos grafo) of
  [] -> Nothing
  (nodo : _) -> Just nodo

agregarArcoNodo :: Nodo -> Arco -> Nodo
agregarArcoNodo nodo arco = construirNodo (nombre nodo) (arco : destinos nodo)

cargarArcos :: [String] -> [Arco]
cargarArcos [] = []
cargarArcos (nombreDestino : pesoStr : destinosStr) =
  let peso = read pesoStr :: Int
   in construirArco nombreDestino peso : cargarArcos destinosStr

cargarNodo :: String -> Nodo
cargarNodo linea =
  case splitOn ',' linea of
    (nombreNodo : destinosStr) ->
      let destinos = cargarArcos destinosStr
       in construirNodo nombreNodo destinos

cargarGrafo :: FilePath -> IO Grafo
cargarGrafo archivo = do
  contenido <- readFile archivo
  let lineas = lines contenido
  let nodos = map cargarNodo lineas
  return (construirGrafo nodos)

imprimirNodo :: Nodo -> String
imprimirNodo nodo = nombre nodo ++ " " ++ show (destinos nodo)

imprimirGrafo :: Grafo -> String
imprimirGrafo grafo = unlines (map imprimirNodo (nodos grafo))

caminoMasCorto :: String -> String -> Grafo -> Maybe Camino
caminoMasCorto inicio fin grafo = caminoMasCorto' [Camino [inicio] 0] []
  where
    caminoMasCorto' caminos visitados = case caminoMasCortoNoVisitado caminos visitados of
      Nothing -> Nothing -- Si no hay caminos para explorar.
      Just caminoActual@(Camino recorridoActual@(actual : _) pesoActual) -- Si el nodo actual es el nodo de destino, devuelve el camino actual como resultado.
        | actual == fin -> Just caminoActual
        | otherwise -> do
            nodoActual <- buscarNodo actual grafo -- Obtiene el nodo actual del grafo.
            let nuevosCaminos =
                  -- Genera nuevos caminos agregando los destinos del nodo actual al principio del recorrido actual y sumando sus pesos al peso actual.
                  [ Camino (destino arco : recorridoActual) (peso arco + pesoActual)
                    | arco <- destinos nodoActual,
                      destino arco `notElem` visitados
                  ]
            caminoMasCorto' -- Llama recursivamente a caminoMasCorto' con la lista de nuevos caminos concatenada a la lista de caminos existentes y el nodo actual agregado a la lista de nodos visitados.
              (nuevosCaminos ++ caminos)
              (actual : visitados)

-- Filtra los caminos cuyo primer nodo todavía no se ha visitado y luego, de estos caminos viables, devuelve el camino con el menor peso total.
caminoMasCortoNoVisitado :: [Camino] -> [String] -> Maybe Camino
caminoMasCortoNoVisitado caminos visitados =
  caminoPesoMinimo (comparing pesoAcumulado) caminosViables
  where
    caminosViables = filter ((`notElem` visitados) . head . recorrido) caminos

-- Encuentra el camino con el peso mínimo en la lista de caminos viables, comparando por el peso acumulado.
caminoPesoMinimo :: (a -> a -> Ordering) -> [a] -> Maybe a
caminoPesoMinimo _ [] = Nothing
caminoPesoMinimo cmp xs = Just (minimumBy cmp xs)

main :: IO ()
main = do
  args <- getArgs
  if length args /= 2
    then putStrLn "Uso: caminoMasCorto <nodoInicio> <nodoFin>"
    else do
      let [salida, llegada] = args
      grafo <- cargarGrafo "../data/grafo.txt"
      let camino = caminoMasCorto salida llegada grafo
      case camino of
        Nothing -> putStrLn "No existe un camino entre los lugares ingresados."
        Just camino -> do
          print (reverse (recorrido camino))