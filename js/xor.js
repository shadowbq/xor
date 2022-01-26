// https://stackoverflow.com/questions/33529103/simply-xor-encrypt-in-javascript-and-decrypt-in-javascript
// * ASCII only

function encryptASCIIStringWithXORtoHex(input,key) {
    var c = '';
    while (key.length < input.length) {
         key += key;
    }
    for(var i=0; i<input.length; i++) {
        var value1 = input[i].charCodeAt(0);
        var value2 = key[i].charCodeAt(0);

        var xorValue = value1 ^ value2;

        var xorValueAsHexString = xorValue.toString("16");

        if (xorValueAsHexString.length < 2) {
            xorValueAsHexString = "0" + xorValueAsHexString;
        }

        c += xorValueAsHexString;
    }
    return c;
}