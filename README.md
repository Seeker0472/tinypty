# tinypty 

A minimum example of how to use pty(Pseudoterminal) in linux.

## Usage

```
make run
screen /dev/pts/xxx
```

## Others

如果想实现更高级的功能,比如
- 以静态/动态库的方式编译
- 使用动态库的方式编译时，安装到 /usr/local/lib目录下
- 在`init_pty` 函数里面启动一个terminal emulator(x11-xterm等)并连接上pty

可以参考[`lib-tinypty`](https://github.com/Seeker0472/tinypty/tree/lib-tinypty)这个branch,此处感谢[@msuadOf](https://github.com/msuadOf)
