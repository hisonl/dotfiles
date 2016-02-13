var resize = function (width, height) {
    return S.op("resize", { "width": width, "height": height });
};

var nudge = function (x, y) {
    return S.op("nudge", { "x": x, "y": y });
};

var cornerTo = function (direction, width, height) {
    return S.op("corner", {
        "direction": direction,
        "width": width,
        "height": height
    });
};

var move = function (x, y, width, height) {
    return S.op("move", {
        "x": x,
        "y": y,
        "width": width,
        "height": height
    });
};

var switchScreen = function (direction) {
    return S.op("move", {
        "x": "screenOriginX",
        "y": "screenOriginY",
        "width": "screenSizeX",
        "height": "screenSizeY",
        "screen": function () {
            var screenId = parseInt(S.screen().id());
            var screenCount = S.screenCount();

            if (direction == "next") {
                screenId = (screenId + 1) % screenCount;
            } else if (direction == "previous") {
                screenId = Math.abs(screenId - 1) % screenCount;
            }

            return screenId.toString();
        }
    });
};

S.bindAll({
    // Resize
    "right:ctrl": resize("+10%", "+0"),
    "left:ctrl": resize("-10%", "+0"),
    "up:ctrl": resize("+0", "-10%"),
    "down:ctrl": resize("+0", "+10%"),

    // Nudge
    "right:ctrl,shift": nudge("+10%", "+0"),
    "left:ctrl,shift": nudge("-10%", "+0"),
    "up:ctrl,shift": nudge("+0", "-10%"),
    "down:ctrl,shift": nudge("+0", "+10%"),

    // Corner
    // "right:cmd,shift": cornerTo("top-right", "screenSizeX/2", "screenSizeY"),
    // "left:cmd,shift": cornerTo("top-left", "screenSizeX/2", "screenSizeY"),
    // "up:cmd,shift": cornerTo("top-left", "screenSizeX", "screenSizeY/2"),
    // "down:cmd,shift": cornerTo("bottom-left", "screenSizeX", "screenSizeY/2"),

    // Move
    "return:cmd,shift": move("screenOriginX", "screenOriginY", "screenSizeX", "screenSizeY"),

    // Switch screen
    "right:cmd": switchScreen("next"),
    "left:cmd": switchScreen("previous"),
    "up:cmd": switchScreen("next"),
    "down:cmd": switchScreen("previous")
});
