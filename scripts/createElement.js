function createElement(name,x,y) {
    var component = Qt.createComponent(name+".qml");
    var sprite

    var finishCreation = function () {
        if (component.status === Component.Ready) {
            sprite = component.createObject(root, {"x": x, "y": y});
            if (sprite === null) console.log("Error creating object "+name);
        } else if (component.status === Component.Error)
            console.log("Error loading component:", component.errorString());
    }

    if (component.status === Component.Ready)
        finishCreation();
    else
        component.statusChanged.connect(finishCreation());
}

function createElementIn(parent,name,x,y) {
    var component = Qt.createComponent(name+".qml");
    var sprite

    var finishCreation = function () {
        if (component.status === Component.Ready) {
            sprite = component.createObject(parent, {"x": x, "y": y});
            if (sprite === null) console.log("Error creating object "+name);
        } else if (component.status === Component.Error)
            console.log("Error loading component:", component.errorString());
    }

    if (component.status === Component.Ready)
        finishCreation();
    else
        component.statusChanged.connect(finishCreation());
}

function createElementColor(name,x,y,color,player,taille) {
    var component = Qt.createComponent(name+".qml");
    var sprite

    var finishCreation = function () {
        if (component.status === Component.Ready) {
            sprite = component.createObject(root, {"x": x, "y": y,"color":color,"player":player,"taille":taille});
            if (sprite === null) console.log("Error creating object "+name);
        } else if (component.status === Component.Error)
            console.log("Error loading component:", component.errorString());
    }

    if (component.status === Component.Ready)
        finishCreation();
    else
        component.statusChanged.connect(finishCreation());
}

function createElementBonus(name,x,y,type) {
    var component = Qt.createComponent(name+".qml");
    var sprite

    var finishCreation = function () {
        if (component.status === Component.Ready) {
            sprite = component.createObject(root, {"xC": x, "yC": y,"type":type});
            if (sprite === null) console.log("Error creating object "+name);
        } else if (component.status === Component.Error)
            console.log("Error loading component:", component.errorString());
    }

    if (component.status === Component.Ready)
        finishCreation();
    else
        component.statusChanged.connect(finishCreation());
}



function createElementProp(name,prop) {
    var component = Qt.createComponent(name+".qml");
    var sprite

    var finishCreation = function () {
        if (component.status === Component.Ready) {
            sprite = component.createObject(root, prop);
            if (sprite === null) console.log("Error creating object "+name);
        } else if (component.status === Component.Error) {
            console.log("Error loading component:", component.errorString());
        }
    }

    if (component.status === Component.Ready)
        finishCreation();
    else
        component.statusChanged.connect(finishCreation());
}
