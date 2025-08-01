alias sbop="python3 -c 'import sys; from pwn import *; io=process(sys.argv[1]); io.sendline(cyclic(0x100));io.wait(); cf=io.corefile; print(cyclic_find(cf.read(cf.rsp,4)))'"
