import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    width: 1000
    height: 850
    visible: true
    title: "Product Manager"
    color: "#f4f6f8"

    ListModel { id: productModel }
    property int editIndex: -1

    function cloneProduct(p) {
        return {
            image: p.image || "",
            id: p.id || "",
            name: p.name || "",
            description: p.description || "",
            longDescription: p.longDescription || "",
            brand: p.brand || "",
            condition: p.condition || "",
            basePrice: p.basePrice || "",
            discountedPrice: p.discountedPrice || "",
            weight: p.weight || "",
            status: p.status || ""
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 12

        // product list
        Rectangle {
            Layout.preferredWidth: 360
            Layout.fillHeight: true
            radius: 8
            color: "white"
            border.color: "#ddd"

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                // product list title
                Label {
                    text: "Products List"
                    font.pixelSize: 18
                    font.bold: true
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    color: "darkblue"
                }

                //scroll listview
                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true

                    ListView {
                        id: listView
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: productModel
                        clip: true

                        delegate: Rectangle {
                            width: listView.width
                            height: 72
                            radius: 6
                            color: ListView.isCurrentItem ? "#d4f5d4" : "transparent"
                            border.color: "#ddd"

                            MouseArea {
                                anchors.fill: parent
                                onClicked: listView.currentIndex = index
                                onDoubleClicked: productView.openWith(productModel.get(index))
                            }

                            // name id in product list display
                            Column {
                                anchors.fill: parent
                                anchors.margins: 8
                                spacing: 2

                                Text { text: "ID: " + id; font.bold: true }
                                Text { text: "Name: " + name }
                                Text {
                                    text: "Description: " + description
                                    elide: Text.ElideRight
                                    color: "#555"
                                }
                            }
                        }
                    }
                } // product list scrollview
            } // product list column layout
        } // product list rectangle



        // add and edit
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 8
            color: "white"
            border.color: "#ddd"

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 14
                spacing: 8

                Label {
                    text: editIndex === -1 ? "Add Product" : "Edit Product"
                    font.pixelSize: 18
                    font.bold: true
                }

                // Image drag and drop box
                Rectangle {
                    id: imageBox
                    Layout.fillWidth: true
                    height: 140
                    radius: 6
                    border.color: "#aaa"
                    color: "#fafafa"
                    property string imagePath: ""

                    Image {
                        anchors.fill: parent
                        anchors.margins: 8
                        source: imageBox.imagePath
                        fillMode: Image.PreserveAspectFit
                    }

                    DropArea {
                        anchors.fill: parent
                        onDropped: function(drop) {
                            if (drop.urls.length > 0)
                                imageBox.imagePath = drop.urls[0]

                            var url = drop.urls[0].toString().toLowerCase()

                            if (url.endsWith(".png") ||
                                url.endsWith(".jpg") ||
                                url.endsWith(".jpeg") ||
                                url.endsWith(".webp")) {

                                imageBox.imagePath = drop.urls[0]
                            } else {
                                console.log("Invalid image type")
                            }
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: imageBox.imagePath === "" ? "Drag & Drop Image Here" : ""
                        color: "#777"
                    }
                }


                // product id input
                Rectangle {
                    id: idInput
                    property alias text: idField.text
                    Layout.fillWidth: true
                    height: 32
                    radius: 5
                    color: "white"
                    border.width: 1
                    border.color: idField.activeFocus ? "#2196f3" : "grey"
                    TextInput {
                        id: idField
                        anchors.fill: parent
                        anchors.margins: 6
                        font.pixelSize: 14
                        color: "black"
                        validator: IntValidator {
                            bottom: 0
                            top: 10000
                        }   
                    }

                    Text {
                        text: "Product ID"
                        color: "#888"
                        visible: idField.text.length === 0
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: idField.forceActiveFocus()
                    }
                }

                //product name input
                Rectangle {
                    id: nameInput
                    property alias text: nameField.text
                    Layout.fillWidth: true
                    height: 32
                    radius: 5
                    color: "white"
                    border.width: 1
                    border.color: nameField.activeFocus ? "#2196f3" : "grey"

                    TextInput {
                        id: nameField
                        anchors.fill: parent
                        anchors.margins: 6
                        font.pixelSize: 14
                        color: "black"
                    }

                    Text {
                        text: "Product Name"
                        color: "#888"
                        visible: nameField.text.length === 0
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: nameField.forceActiveFocus()
                    }
                }

                // short description input
                Rectangle {
                    id: descInput
                    property alias text: descField.text
                    Layout.fillWidth: true
                    height: 30
                    radius: 5
                    color: "white"
                    border.width: 1
                    border.color: descField.activeFocus ? "#2196f3" : "grey"

                    TextEdit {
                        id: descField
                        anchors.fill: parent
                        anchors.margins: 6
                        font.pixelSize: 14
                        color: "black"
                        wrapMode: TextEdit.Wrap
                    }

                    Text {
                        text: "Product Description"
                        color: "#888"
                        visible: descField.text.length === 0
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.margins: 8
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: descField.forceActiveFocus()
                    }
                }

                // long description input
                Rectangle {
                    id: longDescInput
                    property alias text: longDescField.text
                    Layout.fillWidth: true
                    height: 50
                    radius: 5
                    color: "white"
                    border.width: 1
                    border.color: longDescField.activeFocus ? "#2196f3" : "grey"

                    TextInput {
                        id: longDescField
                        anchors.fill: parent
                        anchors.margins: 6
                        font.pixelSize: 14
                        color: "black"
                    }

                    Text {
                        text: "Detailed Description"
                        color: "#888"
                        visible: longDescField.text.length === 0
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: longDescField.forceActiveFocus()
                    }
                }


                // brand name input
                Rectangle {
                    id: brandInput
                    property alias text: brandField.text
                    Layout.fillWidth: true
                    height: 32
                    radius: 5
                    color: "white"
                    border.width: 1
                    border.color: brandField.activeFocus ? "#2196f3" : "grey"

                    TextInput {
                        id: brandField
                        anchors.fill: parent
                        anchors.margins: 6
                        font.pixelSize: 14
                        color: "black"
                    }

                    Text {
                        text: "Brand Name"
                        color: "#888"
                        visible: brandField.text.length === 0
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: brandField.forceActiveFocus()
                    }
                }

               // condition input
                Rectangle {
                    id: conditionInput
                    property alias text: conditionBox.currentText

                    Layout.fillWidth: true
                    height: 32
                    radius: 5
                    color: "white"
                    border.width: 1
                    border.color: conditionBox.activeFocus ? "#2196f3" : "grey"

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 4
                        spacing: 6

                        // Left label (50%)
                        Text {
                            text: "Condition"
                            color: "#888"
                            verticalAlignment: Text.AlignVCenter
                            Layout.fillHeight: true
                            Layout.preferredWidth: parent.width / 2
                        }

                        // drop down menu
                        ComboBox {
                            id: conditionBox
                            Layout.fillHeight: true
                            Layout.preferredWidth: parent.width / 4
                            editable: false
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            background: Rectangle { color: "#969286"; radius: 5; border.color: "black" }
                    
                            model: ["select any one", "New", "Used"]
                        }
                    }
                }



                // base price input
                Rectangle {
                    id: basePriceInput
                    property alias text: basePriceField.text
                    Layout.fillWidth: true
                    height: 32
                    radius: 5
                    color: "white"
                    border.width: 1
                    border.color: basePriceField.activeFocus ? "#2196f3" : "grey"

                    TextInput {
                        id: basePriceField
                        anchors.fill: parent
                        anchors.margins: 6
                        font.pixelSize: 14
                        color: "black"
                        validator: DoubleValidator {
                            bottom: 0.0
                            top: 999999.99
                            decimals: 2
                        }
                    }

                    Text {
                        text: "Base Price"
                        color: "#888"
                        visible: basePriceField.text.length === 0
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: basePriceField.forceActiveFocus()
                    }
                }

                // discounted price input
                Rectangle {
                    id: discountedPriceInput
                    property alias text: discountPriceField.text
                    Layout.fillWidth: true
                    height: 32
                    radius: 5
                    color: "white"
                    border.width: 1
                    border.color: discountPriceField.activeFocus ? "#2196f3" : "grey"

                    TextInput {
                        id: discountPriceField
                        anchors.fill: parent
                        anchors.margins: 6
                        font.pixelSize: 14
                        color: "black"
                        validator: DoubleValidator {
                            bottom: 0.0
                            top: 999999.99
                            decimals: 2
                        }
                    }

                    Text {
                        text: "Discounted Price"
                        color: "#888"
                        visible: discountPriceField.text.length === 0
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                    
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: discountPriceField.forceActiveFocus()
                    }
                }

                // product weight input
                Rectangle {
                    id: weightInput
                    property alias text: weightField.text
                    Layout.fillWidth: true
                    height: 32
                    radius: 5
                    color: "white"
                    border.width: 1
                    border.color: weightField.activeFocus ? "#2196f3" : "grey"

                    TextInput {
                        id: weightField
                        anchors.fill: parent
                        anchors.margins: 6
                        font.pixelSize: 14
                        color: "black"
                        validator: DoubleValidator {
                            bottom: 0.0
                            top: 999999.99
                            decimals: 2
                        }
                    }

                    Text {
                        text: "Product Weight"
                        color: "#888"
                        visible: weightField.text.length === 0
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: weightField.forceActiveFocus()
                    }
                }

                // status input
                Rectangle {
                    id: statusInput
                    property alias text: statusField.text
                    Layout.fillWidth: true
                    height: 32
                    radius: 5
                    color: "white"
                    border.width: 1
                    border.color: statusField.activeFocus ? "#2196f3" : "grey"

                    TextInput {
                        id: statusField
                        anchors.fill: parent
                        anchors.margins: 6
                        font.pixelSize: 14
                        color: "black"

                        // string validation
                        validator: RegularExpressionValidator {
                            regularExpression: /^[A-Za-z ]+$/
                        }
                    }

                    Text {
                        text: "Status (Active, Inactive)"
                        color: "#888"
                        visible: statusField.text.length === 0
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: statusField.forceActiveFocus()
                    }
                }
               
                RowLayout {
                    spacing: 10

                    Button {
                        id: myButton
                        text: editIndex === -1 ? "Add" : "Update"
                        background: Rectangle { color: "#6ab342"; radius: 5 }
                         contentItem: Text {
                            text: myButton.text
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: {
                            var p = {
                                image: imageBox.imagePath,
                                id: idField.text,
                                name: nameField.text,
                                description: descField.text,
                                longDescription: longDescField.text,
                                brand: brandField.text,
                                condition: conditionBox.currentText,
                                basePrice: basePriceField.text,
                                discountedPrice: discountPriceField.text,
                                weight: weightField.text,
                                status: statusField.text
                            }

                            if (editIndex === -1)
                                backend.addProduct(p)
                            else
                                backend.updateProduct(editIndex, p)
                        }
                    }

                    //delete button
                    Button {
                        id: deleteButton
                        text: "Delete"
                        enabled: editIndex !== -1
                        background: Rectangle { color: "#bb5c44"; radius: 5 }
                         contentItem: Text {
                            text: deleteButton.text
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: deletePopup.open()
                    }

                    //clear button
                    Button {
                        id: clearButton
                        text: "Clear"
                        background: Rectangle {
                            color: '#e2f253'
                            radius: 5
                            }

                        contentItem: Text {
                            text: clearButton.text
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: clearForm()
                    }
                }
            }
        } // add and edit rectangle

    } // outermost row layout

    //clear function
    function clearForm() {
        editIndex = -1
        idField.text = ""
        nameField.text = ""
        descField.text = ""
        longDescField.text = ""
        brandField.text = ""
        conditionBox.currentText = ""
        basePriceField.text = ""
        discountPriceField.text = ""
        weightField.text = ""
        statusField.text = ""
        imageBox.imagePath = ""
        listView.currentIndex = -1
    }


    // LIST SELECTION → FORM
    Connections {
        target: listView
        function onCurrentIndexChanged() {
            if (listView.currentIndex < 0) return
            
            var p = productModel.get(listView.currentIndex)
            editIndex = listView.currentIndex

            imageBox.imagePath = p.image
            idField.text = p.id
            nameField.text = p.name
            descField.text = p.description
            longDescField.text = p.longDescription
            brandField.text = p.brand
            conditionBox.currentText = p.condition
            basePriceField.text = p.basePrice
            discountPriceField.text = p.discountedPrice
            weightField.text = p.weight
            statusField.text = p.status
        }
    }

    // PRESENTER → VIEW
    Connections {
        target: backend

        function onProductAdded(p) {
            productModel.append(cloneProduct(p))
            clearForm()
        }

        function onProductUpdated(i, p) {
            productModel.set(i, cloneProduct(p))
            clearForm()
        }

        function onProductDeleted(i) {
            productModel.remove(i)
            clearForm()
        }
    }

    Popup {
        id: deletePopup
        modal: true
        anchors.centerIn: parent

        Rectangle {
            width: 220
            height: 100
            radius: 6
            color: "white"
            border.color: "#444"

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 10

                Label {
                    text: "Delete this product?"
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    color: "darkred"
                    font.pixelSize: 16
                }

                RowLayout {
                    spacing: 10
                    Button { 
                        id: cancelButton
                        text: "Cancel";
                        background: Rectangle { color: "#6ab342"; radius: 5 }
                         contentItem: Text {
                            text: cancelButton.text
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        } 
                        onClicked: deletePopup.close() 
                        }

                    Button {
                        text: "Delete"
                        background: Rectangle { color: "#bb5c44"; radius: 5 }
                         contentItem: Text {
                            text: deleteButton.text
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: {
                            backend.deleteProduct(editIndex)
                            deletePopup.close()
                        }
                    }

                } // row layout

            } // delete coloumnlayout

        } // popup rectangle

    } // delete popup

    ProductView { id: productView }

} // application window 
