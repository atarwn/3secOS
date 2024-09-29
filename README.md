# 3secOS

```ascii
  _____                ___  ____  
 |___ / ___  ___  ___ / _ \/ ___| 
   |_ \/ __|/ _ \/ __| | | \___ \ 
  ___) \__ \  __/ (__| |_| |___) |
 |____/|___/\___|\___|\___/|____/ 
```

3secOS is a minimalistic operating system that fits in just 3 sectors (1536 bytes), with 1 sector for booting and 2 sectors for the system itself. It's a fork of the original bootOS by Oscar Toledo G., with improvements to the user interface and system interaction.

## Features

- Bootable OS image
- Simple command-line interface
- Basic file operations (list, remove, format)
- Hexadecimal editor
- Disk read/write operations
- Compact size: only 3 sectors (1536 bytes)

## Commands

- `ls`: List files
- `rm`: Remove file
- `ft`: Format disk
- `hx`: Hexadecimal editor
- `i`: Show help information

## Filesystem Organization

3secOS uses a simple filesystem structure:

- The system itself occupies the first 3 sectors of the disk (boot sector + 2 sectors for the OS).
- The directory is contained in the fourth sector.
- Each directory entry is 16 bytes wide, containing the ASCII name of the file terminated with a zero byte.
- A sector has a capacity of 512 bytes, allowing for 32 files on a floppy disk.
- Deleting a file zeroes its entire directory entry.
- Each file is one sector long, with its location derived from its position in the directory.
- Files are located sequentially from track 1 to track 32, side 0, sector 1.

## Building

To build the OS image, you need NASM (Netwide Assembler) installed on your system. Use the provided Makefile to compile and create the bootable image:

```bash
make
```

This will generate the `bootable.img` file.

## Starting 3secOS

1. Write the system to the boot sector of a floppy disk.
2. 3secOS is compatible with various floppy disk sizes (360K, 720K, 1.2MB, and 1.44MB).
3. For emulation, use a .img file of appropriate size (360K, 720K, or 1440K).

### Creating a custom-sized Disk Image (for Mac OS and Linux)

To create a 360K image:

```bash
dd if=/dev/zero of=oszero.img count=719 bs=512
cat boot.bin os.bin oszero.img > bootable.img
```

For 720K, use count=1439; for 1.44M, use count=2879.

## Running

You can run the OS using QEMU:

```bash
make run
```

Or manually with:

```bash
qemu-system-i386 -fda bootable.img
```

On first run, use the 'ft' (format) command to initialize the directory. This also copies the system to the boot sector, useful for initializing new disks.

## Using 3secOS

### Hexadecimal Editor

The `hx` command allows you to enter up to 512 hexadecimal bytes to create a file. 

Example usage:

```
>hx
#17
#
*gg
>ls
gg
>/gg
3secOS
>
```

Note: The '#' prompt indicates hex input, and '*' prompts for the filename.

## Cleaning Up

To remove generated files:

```bash
make clean
```

To remove all generated files including the bootable image:

```bash
make clear
```

## Project Structure

- `os.asm`: Main operating system code (2 sectors)
- `boot.asm`: Boot sector code (1 sector)
- `Makefile`: Build automation

## Improvements

Compared to the original bootOS, 3secOS includes:
- Enhanced user interface
- Improved system interaction
- 3-sector design (1536 bytes total)

## Known Issues

- I don't really understand the process of running third-party programs on this system, so there may be problems with this in the system itself

## Available Space

Despite its compact size, there is still a significant amount of free space available within the 3 sectors. This leaves room for potential future enhancements or additional features.

## Contributing

Contributions to 3secOS are welcome. Please feel free to submit a Pull Request.

## License

```sql
BSD 2-Clause License

Copyright (c) 2019, Oscar Toledo G. http://nanochess.org/
Copyright (c) 2024, atarwn https://qwa.su

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```

## Acknowledgements

- Original bootOS by Oscar Toledo G. [(https://github.com/nanochess/bootOS)](https://github.com/nanochess/bootOS)
- Improvements and 3secOS fork by [atarwn](https://github.com/atarwn)
