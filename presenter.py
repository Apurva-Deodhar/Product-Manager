from PySide6.QtCore import QObject, Signal, Slot
from model import ProductModel

class ProductPresenter(QObject):
    productAdded = Signal(dict)
    productUpdated = Signal(int, dict)
    productDeleted = Signal(int)

    def __init__(self):
        super().__init__()
        self._model = ProductModel()

    @Slot(dict)
    def addProduct(self, product):
        clean = self._model.normalize(product)
        self._model.add(clean)
        print("ADD:", clean)
        self.productAdded.emit(clean)

    @Slot(int, dict)
    def updateProduct(self, index, product):
        clean = self._model.normalize(product)
        self._model.update(index, clean)
        print("UPDATE:", index, clean)
        self.productUpdated.emit(index, clean)

    @Slot(int)
    def deleteProduct(self, index):
        self._model.delete(index)
        print("DELETE:", index)
        self.productDeleted.emit(index)
