function createElement(name, idparent) {
    var component = Qt.createComponent(name);
    var sprite

    var finishCreation = function () {
        if (component.status === Component.Ready) {
            sprite = component.createObject(idparent);
             if (sprite === null) console.log("Error creating object " + name);
        } else if (component.status === Component.Error)
            console.log("Error loading component:", component.errorString());
    }

    if (component.status === Component.Ready)
        finishCreation();
    else
        component.statusChanged.connect(finishCreation());
}
