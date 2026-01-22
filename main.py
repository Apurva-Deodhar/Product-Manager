import sys
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from presenter import ProductPresenter

app = QGuiApplication(sys.argv)

engine = QQmlApplicationEngine()
presenter = ProductPresenter()

engine.rootContext().setContextProperty("backend", presenter)
engine.load("qml/main.qml")

if not engine.rootObjects():
    sys.exit(-1)

sys.exit(app.exec())
