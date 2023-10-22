# -*- coding: utf-8 -*-

import sys
import utilidades
from PyQt5 import QtWidgets, uic
from PyQt5 import QtGui
from ast import literal_eval
import subprocess


class Gui(QtWidgets.QMainWindow):
    __instance: uic = None

    @staticmethod
    def get_instance():
        if Gui.__instance is None:
            Gui()
        return Gui.__instance

    def __init__(self) -> None:
        super().__init__()
        if Gui.__instance is not None:
            raise Exception("No se permiten varias instancias del gui.")
        else:
            try:
                Gui.__instance = uic.loadUi("view.ui", self)
                self.origen_comboBox.addItems(
                    [lugar.nombre for lugar in utilidades.lugares])
                self.destino_comboBox.addItems(
                    [lugar.nombre for lugar in utilidades.lugares])
                self.confirmar_pushButton.clicked.connect(self.confirmar)
            except:
                print("Error inesperado: ", sys.exc_info()[0])

    def confirmar(self):
        id_origen: str = utilidades.obtener_id_lugar(
            self.origen_comboBox.currentText())
        id_destino: str = utilidades.obtener_id_lugar(
            self.destino_comboBox.currentText())

        resultado_haskell = subprocess.run(
            ["runhaskell", "../logic/Grafo.hs", id_origen, id_destino], stdout=subprocess.PIPE, text=True)
        salida_haskell = resultado_haskell.stdout.strip()
        camino = literal_eval(salida_haskell)

        utilidades.reiniciar_colores_arcos()
        for i in range(len(camino)):
            if i+1 < len(camino):
                utilidades.cambiar_color_arco(camino[i], camino[i+1])

        tiempo_actual: int = utilidades.obtener_tiempo()
        utilidades.generar_grafo(id_grafo=tiempo_actual)
        self.imagen_label.setPixmap(QtGui.QPixmap(
            f"assets/grafo{tiempo_actual}.png"))
        
        ruta_ideal: str = "Su ruta ideal es..."
        for nodo in camino:
            ruta_ideal += f"\n{utilidades.obtener_nombre_lugar(nodo)}"
        self.ruta_ideal_textEdit.setText(ruta_ideal)
