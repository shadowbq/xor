#!/usr/bin/env bash

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 enc|dec key data"
    exit 1
fi

if [[ -p /dev/stdin ]]; then
    teststring="$(cat -)"
fi

echo "teststring: $teststring"

# requirements:
command -v openssl >/dev/null 2>&1 || { echo >&2 "openssl command gpg not found in path."; exit 255; }

Asc() { printf '%d' "'$1"; }
HexToDec() { printf '%d' "0x$1"; }

XOREncrypt(){
    local key="$1" DataIn="$2"
    local ptr DataOut val1 val2 val3

    for (( ptr=0; ptr < ${#DataIn}; ptr++ )); do

        val1=$( Asc "${DataIn:$ptr:1}" )
        val2=$( Asc "${key:$(( ptr % ${#key} )):1}" )
        val3=$(( val1 ^ val2 ))

        DataOut+=$(printf '%02x' "$val3")

    done
    printf '%s' "$DataOut"
}

XORDecrypt() {

    local key="$1" DataIn="$2"
    local ptr DataOut val1 val2 val3
    local ptrs
    ptrs=0
    #echo "XORDecrypter"
    for (( ptr=0; ptr < ${#DataIn}/2; ptr++ )); do

        val1="$( HexToDec "${DataIn:$ptrs:2}" )"
        val2=$( Asc "${key:$(( ptr % ${#key} )):1}" )
        val3=$(( val1 ^ val2 ))

        ptrs=$((ptrs+2))

        DataOut+=$( printf \\$(printf "%o" "$val3") )

    done
    printf '%s' "$DataOut"
}

Operation="$1"

CodeKey=$(echo -n "$2" | openssl sha512)
echo "CodeKey: $CodeKey"
#read -r teststring

if [ "$Operation" == "enc" ] || [ "$Operation" == "encrypt" ]; then
    echo "running enc"
    teststring="$( echo "$teststring" | openssl base64 )"
    echo "teststring-b64: $teststring"
    XOREncrypt "$CodeKey" "$teststring"
elif [ "$Operation" == "dec" ] || [ "$Operation" == "decrypt" ]; then
    echo "running dec"
    teststringb64=$(XORDecrypt "$CodeKey" "$teststring") 
    echo "teststring-b64: $teststringb64"
    echo $teststringb64| openssl base64 -d
fi