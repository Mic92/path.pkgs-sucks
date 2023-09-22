# pkgs.path benchmark

Appearantly using pkgs.path, makes your hello evaluation a lot slower.

Watch this!

```console
$ nix run github:Mic92/pkgs.path-sucks
hello without pkgs.path
"/nix/store/46i21v678kqbn556jyqkmg0g27ph9r3l-hello-2.12.1"

real    0m0.246s
user    0m0.137s
sys     0m0.079s
hello with pkgs.path
"/nix/store/bydmjwsngb2w8gxfwmw62620sblqy6r2-hello-2.12.1"

real    0m4.978s
user    0m0.428s
sys     0m0.543s
```
