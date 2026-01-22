from PySide6.QtCore import QObject, Signal, Slot
from model import ProductModel

class ProductController(QObject):
    productsChanged = Signal(list)

    def __init__(self):
        super().__init__()
        self._model = ProductModel()

    @Slot(str, "QVariant")
    def addProduct(self, name, price):
        print("ADD clicked:", name, price)

        try:
            price = float(price)
        except (TypeError, ValueError):
            price = 0.0

        self._model.add_product(name, price)
        self.productsChanged.emit(self._model.get_products())

    @Slot(int)
    def removeProduct(self, index):
        self._model.remove_product(index)
        self.productsChanged.emit(self._model.get_products())

    @Slot()  
    def loadProducts(self):
        self.productsChanged.emit(self._model.get_products())
