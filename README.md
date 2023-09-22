# pkgs.path benchmark

Appearantly using pkgs.path, makes your hello evaluation a lot slower.

Watch this!

```console
$ nix run github:Mic92/pkgs.path-sucks#benchmark
fast
"/nix/store/xsrrq6lx9s42dpq2ylm5f7jkf33gafzs-hello-2.12.1"

real    0m0.237s
user    0m0.080s
sys     0m0.129s
slow
"/nix/store/bydmjwsngb2w8gxfwmw62620sblqy6r2-hello-2.12.1"

real    0m4.829s
user    0m0.438s
sys     0m0.505s
```
