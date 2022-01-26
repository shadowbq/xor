# XOR - Shell

## Limitation of `POSIX`

POSIX gnu tools in common shells (aka bash/sh/ksh) don't process NULL bytes and often use the NULL byte as delimiter. Historically, tools written in C tend to use NUL delimited strings. In puts(var), puts() outputs the content of var up to the first NUL character. Those APIs can't be used if you want to support the NUL character in your strings, you need to represent strings some other way than by using a NUL terminator.

## Usage

```shell
echo -n '3f5a5f1b03165958'|./xor.bash dec "foo"
teststring: 3f5a5f1b03165958
CodeKey: f7fbba6e0636f890e56fbbf3283e524c6fa3204ae298382d624741d0dc6638326e282c41be5e4254d8820772c5518a2c5a8c0c7f7eda19594a7eb539453e1ed7
running dec
teststring-b64: Ym9yawo=
bork


echo -n bork|./xor.bash enc "foo"
teststring: bork
CodeKey: f7fbba6e0636f890e56fbbf3283e524c6fa3204ae298382d624741d0dc6638326e282c41be5e4254d8820772c5518a2c5a8c0c7f7eda19594a7eb539453e1ed7
running enc
teststring-b64: Ym9yawo=
3f5a5f1b03165958
```

### Validation

```shell
$> echo -n bork|shell/xor.bash enc "foo"|tail -1 |shell/xor.bash dec "foo"|tail -1
bork
```
