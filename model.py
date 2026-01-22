class ProductModel:
    def __init__(self):
        self._products = []

    def add(self, product):
        self._products.append(product)

    def update(self, index, product):
        if 0 <= index < len(self._products):
            self._products[index] = product

    def delete(self, index):
        if 0 <= index < len(self._products):
            self._products.pop(index)

    def normalize(self, product):
        return {
            "image": product.get("image", ""),
            "id": product.get("id", ""),
            "name": product.get("name", ""),
            "description": product.get("description", ""),
            "longDescription": product.get("longDescription", ""),
            "brand": product.get("brand", ""),
            "condition": product.get("condition", ""),
            "basePrice": product.get("basePrice", ""),
            "discountedPrice": product.get("discountedPrice", ""),
            "weight": product.get("weight", ""),
            "status": product.get("status", "")
        }
