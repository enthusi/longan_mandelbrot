# Fast fixed point mandelbrot for the Longan Nano board

## What is this?

A simple test case to compute and render a fast mandelbrot zoomer to the 160x80 LCD display
of the Longan Nano board. It relies on the setup and environment of [gd32vf103inator].

mandelfp() Code: Martin Wendt

## Compiling

Get a RISC-V toolchain as explained in the [gd32vf103inator] readme, and do

```sh
git clone https://github.com/enthusi/longan_mandelbrot.git
cd longan_mandelbrot
git submodule init
git submodule update
make
```

## License

This project is licensed under the [BSD 3-Clause][bsd-3] license just like
the [firmware library][firmware] released by GigaDevice and gd32vf103inator itself.
Register and bit definitions are copied from there and modified to be usable
without including the rest of the library.

[bsd-3]: https://opensource.org/licenses/BSD-3-Clause
[firmware]: https://github.com/riscv-mcu/GD32VF103_Firmware_Library/
[gd32vf103inator]: https://github.com/esmil/gd32vf103inator/
