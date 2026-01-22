import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id: productWindow
    width: 700
    height: 800
    visible: false
    title: "Product Details"
    color: "#d4e4fc"

    property var product: ({})

    // function to open the window with input product data
    function openWith(p) {
    if (!p) {
        product = {
            image: "",
            id: "",
            name: "",
            description: "",
            longDescription: "",
            brand: "",
            condition: "",
            basePrice: "",
            discountedPrice: "",
            weight: "",
            status: ""
        }
    } else {
        product = p
    }
    visible = true
    }


    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 12

        // Main title
        Label {
            text: "PRODUCT DETAILS"
            font.pixelSize: 20
            font.bold: true
            font.underline: true
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            color: "darkblue"
        }

        // info area
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 6
            border.width: 2
            border.color: "green"
            color: "white"

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 14
                spacing: 10

                // product name
                Label {
                    text: product.name ?? ""
                    font.pixelSize: 18
                    font.bold: true
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                }

                // product image display
                Rectangle {
                    Layout.fillWidth: true
                    height: 220
                    radius: 5
                    border.color: "#aaa"
                    color: "#fafafa"

                    Image {
                        anchors.fill: parent
                        anchors.margins: 8
                        source: product.image ?? ""
                        fillMode: Image.PreserveAspectFit
                    }
                }

                // all product info
                GridLayout {
                    columns: 2
                    columnSpacing: 12
                    rowSpacing: 6
                    Layout.fillWidth: true

                    // product id
                    Label { text: "ID:"; font.bold: true; color: "black"}
                    Text {
                        text: product.id ?? ""
                        wrapMode: Text.WordWrap
                        color: "#444"
                        Layout.fillWidth: true
                    }

                    //product name
                    Label { text: "Name:"; font.bold: true; color: "black" }
                    Text {
                        text: product.name ?? ""
                        wrapMode: Text.WordWrap
                        color: "#444"
                        Layout.fillWidth: true
                    }

                    // product short description
                    Label { text: "Description:"; font.bold: true; color: "black" }
                    Text {
                        text: product.description ?? ""
                        wrapMode: Text.WordWrap
                        color: "#444"
                        Layout.fillWidth: true
                    }

                    // product long description
                    Label { text: "Long Description:"; font.bold: true; color: "black" }
                    Text {
                        text: product.longDescription ?? ""
                        wrapMode: Text.WordWrap
                        color: "#444"
                        Layout.fillWidth: true
                    }

                    // brand name
                    Label { text: "Brand :"; font.bold: true; color: "black" }
                    Text {
                        text: product.brand ?? ""
                        wrapMode: Text.WordWrap
                        color: "#444"
                        Layout.fillWidth: true
                    }

                    // product condition
                    Label { text: "Condition:"; font.bold: true; color: "black" }
                    Text {
                        text: product.condition ?? ""
                        wrapMode: Text.WordWrap
                        color: "#444"
                        Layout.fillWidth: true
                     }
                    
                    // product status
                    Label { text: "Status:"; font.bold: true; color: "black" }
                    Text {
                        text: product.status ?? ""
                        wrapMode: Text.WordWrap
                        color: "#444"
                        Layout.fillWidth: true
                    }

                    // product weight
                    Label { text: "Weight:"; font.bold: true; color: "black" }
                    Text {
                        text: product.weight ?? ""
                        wrapMode: Text.WordWrap
                        color: "#444"
                        Layout.fillWidth: true
                    }

                    // base price
                    Label { text: "Base Price:"; font.bold: true; color: "black" }
                    Text {
                        text: product.basePrice ?? ""
                        wrapMode: Text.WordWrap
                        color: "#444"
                        Layout.fillWidth: true
                    }

                    // discounted price
                    Label { text: "Discounted Price:"; font.bold: true; color: "black" }
                    Text {
                        text: product.discountedPrice ?? ""
                        wrapMode: Text.WordWrap
                        color: "#444"
                        Layout.fillWidth: true
                    }
                }

                Rectangle { height: 1; Layout.fillWidth: true; color: "#ccc" }
            }
        } // info rectangle

        // close button
        Button {
            text: "Close"
            Layout.alignment: Qt.AlignHCenter
            background: Rectangle {
                color: "#6ab342"
                radius: 5
            }
            onClicked: productWindow.visible = false
        }
    }
} // Window 
