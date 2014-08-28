import QtQuick 2.0

// fixed font for command input and output
//FontLoader { id: fixedFont; name: "Monospace" }
FontLoader { id: fixedFont; name: "Liberation Mono" }

Text {
    font.family: fixedFont.name
}
