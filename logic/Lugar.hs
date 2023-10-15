module Lugar where

import Utilidades (splitOn)

data Tipo = NA | Hotel | Atraccion | Obstaculo deriving (Show, Eq, Ord, Enum)

data Lugar = Lugar
  { identificacion :: String,
    nombre :: String,
    tipo :: Tipo
  }
  deriving (Show, Eq, Ord)

construirLugar :: String -> String -> Tipo -> Lugar
construirLugar = Lugar

cargarLugar :: String -> Lugar
cargarLugar linea =
  case splitOn ',' linea of
    [identificacion, nombre, tipoStr] ->
      let tipoLugar = read tipoStr :: Int
       in construirLugar identificacion nombre (toEnum tipoLugar)

cargarLugares :: FilePath -> IO [Lugar]
cargarLugares archivo = do
  contenido <- readFile archivo
  let lineas = lines contenido
  return (map cargarLugar lineas)

imprimirLugar :: Lugar -> String
imprimirLugar lugar = "(" ++ identificacion lugar ++ ") " ++ nombre lugar

imprimirLugares :: [Lugar] -> String
imprimirLugares lugares = unlines (map imprimirLugar lugares)

devolverLugares :: IO ()
devolverLugares = do
  lugares <- cargarLugares "../data/lugares.txt"
  putStrLn (imprimirLugares lugares)