/*globals cordova, window*/
'use strict';
function MacosShell() {}
MacosShell.prototype.executeCommand = function(command, callback) {
    cordova.exec(callback, null, "MacosShell", "executeCommand", [command]);
};
MacosShell.install = function() {
    if(!window.plugins) {
        window.plugins = {};
    }
    window.plugins.MacosShell = new MacosShell();
    return window.plugins.MacosShell;
};
cordova.addConstructor(MacosShell.install);