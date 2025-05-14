# tinypty 

A minimum example of how to use pty(Pseudoterminal) in linux.

## Usage

原理：
```
make run
screen /dev/pts/xxx
```

在init_pty()函数中添加了函数，
自动运行命令`xterm -hold -e bash -c "screen </path/to/pty,eg. /dev/pts/xxx>; echo Press any key to exit; read"`
```c
  sprintf(cmd, "xterm -hold -e bash -c \"screen %s; echo Press any key to exit; read\" &", slave_name);
  system(cmd);
```

并打包成静态库/动态库
`build/libtinypty.a`和`build/libtinypty.so`

只需(静态和动态都一样)
```shell
gcc -I./inc/ -o ./build/tinypty src/main.c -L./build -ltinypty && ./build/tinypty
```
需要注意的是，动态链接需要将库文件路径添加`LD_LIBRARY_PATH`

具体见Makefile的`test`和`test-*`这些个target

## expamples

1. 编译相关

Makefile的`test`和`test-*`这些个target：

```shell
gcc  -o ./build/tinypty src/main.c -L./build -ltinypty
```

2. API 使用

见`src/main.c`，这个文件在编译库的时候是排除在外的
可以成为一个调用参考
