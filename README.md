# Proyecto de investigación - Haskell

> Octubre de 2023

## Paradigmas de programación

## Integrantes

- Isaac Fabián Palma Medina
- Karla Verónica Quiros Delgado

## Descripción del Proyecto

Este repositorio tiene como objetivo proporcionar una visión completa de las funcionalidades del lenguaje de programación **Haskell**.

## Ejemplo

### Problema

![](resources/logo.fQ9)

La empresa **ViajaXpress** necesita un sistema que permita a sus clientes planificar su ruta de viaje. Para lograrlo, el cliente puede elegir entre las siguientes opciones:

- **Hoteles.**
- **Atracciones.**

Además, pueden encontrarse con **Obstáculos** en el camino. El objetivo es proporcionar al cliente la mejor ruta posible, al mejor precio, ¡incluso permitiendo que visite más de una atracción!

La distribución actual de los **Lugares** es la siguiente:

![](resources/graph.png)

### Ejecución de la solución

1. Tener instalado [Haskell](https://www.haskell.org/ghcup/).
2. Clonar el repositorio y acceder a la carpeta del proyecto.
3. Acceder a la carpeta `logic`.
4. Ejecutar el comando `ghci`.
5. Cargar el archivo `Interfaz.hs` con el comando `:l Interfaz`.
6. Ejecutar el comando `main`.
7. Será mostrado un menú con las opciones disponibles:

```
>>>>>>>>> Bienvenid@ a la agencia ViajaXpress <<<<<<<<<
Ofrecemos los mejores destinos a los mejores precios.

Planifique su viaje, ingrese la ubicacion de salida y de llegada.
>>>>>>>>> Nuestros destinos <<<<<<<<<
(AI) Peaje 2
(AA) Hotel Perlas
(AF) Peaje 1
(AM) Museo de Arte Moderno
(AD) Puente angosto 1
(AE) Calle rota 1
(AL) Museo de Ciencias Naturales
(AB) Hotel Las Rocas
(AJ) Parque La Costa
(AK) Restaurante La Farola
(AC) Hotel Gran Sol
(AG) Puente angosto 2
(AN) Playa Grande
(AH) Calle rota 2

(SS) Salir

Ingrese la ubicacion de salida: ...
```

## Referencias

Lipovača, M. (2011). *Learn You a Haskell for Great Good!*. Recuperado de: http://learnyouahaskell.com/chapters