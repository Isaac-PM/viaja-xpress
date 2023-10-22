# -*- coding: utf-8 -*-

"""
Salida = origen
Llegada = destino
"""

import sys
import view_manager as vm
from PyQt5 import QtGui, uic
from PyQt5.QtWidgets import QApplication, QMainWindow


def main():
    app = QApplication(sys.argv)
    instancia_app = vm.Gui().get_instance()
    instancia_app.show()
    instancia_app.setWindowTitle("Agencia de viajes ViajaXpress")
    instancia_app.setWindowIcon(QtGui.QIcon("assets/icon.png"))
    instancia_app.setFixedSize(953, 455)
    sys.exit(app.exec_())


if __name__ == "__main__":
    main()
