# -*- coding: utf-8 -*-

import igraph as ig
import matplotlib.pyplot as plt
from time import time


def obtener_tiempo() -> int:
    return round(time() * 1000)


global color_lugar
color_lugar: dict[str, str] = {
    'Hotel': 'green',
    'Atracción': 'violet',
    'Obstáculo': '#D36E70'
}


class Lugar():
    def __init__(self, id: str, numero: int, nombre: str, tipo: str) -> None:
        self.id = id
        self.numero = numero
        self.nombre = nombre
        self.tipo = tipo
        self.color = color_lugar[tipo]


global lugares
lugares: list[Lugar] = [
    Lugar('AA', 0, 'Hotel Perlas', 'Hotel'),
    Lugar('AB', 1, 'Hotel Las Rocas', 'Hotel'),
    Lugar('AC', 2, 'Hotel Gran Sol', 'Hotel'),
    Lugar('AD', 3, 'Puente angosto 1', 'Obstáculo'),
    Lugar('AE', 4, 'Calle rota 1', 'Obstáculo'),
    Lugar('AF', 5, 'Peaje 1', 'Obstáculo'),
    Lugar('AG', 6, 'Puente angosto 2', 'Obstáculo'),
    Lugar('AH', 7, 'Calle rota 2', 'Obstáculo'),
    Lugar('AI', 8, 'Peaje 2', 'Obstáculo'),
    Lugar('AJ', 9, 'Parque La Costa', 'Atracción'),
    Lugar('AK', 10, 'Restaurante La Farola', 'Atracción'),
    Lugar('AL', 11, 'Museo de Ciencias Naturales', 'Atracción'),
    Lugar('AM', 12, 'Museo de Arte Moderno', 'Atracción'),
    Lugar('AN', 13, 'Playa Grande', 'Atracción')
]


def obtener_id_lugar(nombre: str) -> str:
    for lugar in lugares:
        if lugar.nombre == nombre:
            return lugar.id

def obtener_nombre_lugar(id: str) -> str:
    for lugar in lugares:
        if lugar.id == id:
            return lugar.nombre

cantidad_nodos: int = 14

arcos: list[tuple] = [(0, 3), (0, 5), (0, 6), (1, 2), (1, 5),
                      (1, 6), (1, 8), (1, 11), (1, 13), (2, 7),
                      (2, 10), (2, 12), (2, 13), (3, 7), (3, 13),
                      (4, 8), (4, 11), (4, 12), (5, 11), (6, 13),
                      (7, 13), (7, 10), (8, 9), (8, 11), (8, 12),
                      (8, 13), (9, 10), (9, 12)]

global colores_arcos
colores_arcos: dict[tuple[int, int], str] = {(x, y): 'grey' for x, y in arcos}


def reiniciar_colores_arcos() -> None:
    global colores_arcos
    colores_arcos = {(x, y): 'grey' for x, y in arcos}


def cambiar_color_arco(id_origen: str, id_destino: str, color: str = 'orange') -> None:
    def obtener_numero(id: str) -> int:
        for lugar in lugares:
            if lugar.id == id:
                return lugar.numero

    numero_origen: int = obtener_numero(id_origen)
    numero_destino: int = obtener_numero(id_destino)
    colores_arcos[(numero_origen, numero_destino)] = color
    colores_arcos[(numero_destino, numero_origen)] = color


pesos: list[int] = [10, 1, 6, 5, 7, 2, 10, 3, 6, 1, 4, 2,
                    2, 4, 3, 2, 3, 4, 2, 5, 1, 2, 1, 10, 6, 3, 3, 5]


def generar_grafo(
        pesos: list[int] = pesos,
        cantidad_nodos: int = cantidad_nodos,
        arcos: list[tuple] = arcos,
        id_grafo: int = None) -> None:
    grafo = ig.Graph(cantidad_nodos, arcos)
    grafo.es['weight'] = pesos
    grafo.vs['name'] = [lugar.nombre for lugar in lugares]

    fig, ax = plt.subplots(figsize=(17, 8.5))
    ig.plot(
        grafo,
        target=ax,
        layout='kk',
        vertex_size=50,
        vertex_frame_width=1.0,
        vertex_label_size=14.0,
        vertex_color=[lugar.color for lugar in lugares],
        vertex_label=grafo.vs['name'],
        edge_color=[colores_arcos[(x, y)] for x, y in arcos],
        edge_width=5.0
    )

    if id_grafo is not None:
        fig.savefig(f'assets/grafo{id_grafo}.png', bbox_inches='tight')
    else:
        tiempo_actual: int = obtener_tiempo()
        fig.savefig('assets/grafo' + str(tiempo_actual) +
                    '.png', bbox_inches='tight')
