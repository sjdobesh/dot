# dot files
*last updated : 3.30.26*

## quick setup

```
sudo apt update
sudo apt upgrade -y
sudo apt install git -y
git clone https://github.com/sjdobesh/dot.git
./dot/dotfiles/scripts/bin/setup
```


## packages
### core
barebones utilities for linux, idk what you could even do without these.

| pkg | functionality |
| -- | -- |
| curl | URL interactions         |
| git  | version control          |
| ssh  | remote shell connection  |
| vim  | default text editor      |

### networking 
basic linux networking admin tools 
| pkg | functionality |
| -- | -- |
| iproute2 | modern tools like ip, ss, iw, tc. <br> supports netlink socket protocol, VLANs, policy routing, etc. |
| net-tools  |  legacy tools like ifconfig, route, netstat, etc. |

### c-dev
basic c development tools

| pkg | functionality |
| -- | -- |
| bear  | compilation database generator |
| build-essential  | gnu c build chain |
| clang  | llvm based compiler |
| clang-tools | llvm based utils (formatting, debugging, etc.) |
| cmake | high level build system |
| gdb | gnu debugger |
| lldb  | llvm debugger |
| valgrind | memory analyzer |

### c-xtra
commonly used c dev libraries
| pkg | functionality |
| -- | -- |
| libclang-dev | clang lib       |
| libncurses-dev | tui lib       |
| libpng-dev | png format lib    |
| libsdl3-dev | SDL3 graphics lib |
| libsdl3-image-dev | SDL3 lib for loading images to SDL surfaces or textures      |
| libsdl3-ttf-dev | SDL3 lib for loading fonts   |
                                
### [nvim dependencies](https://neovim.io/doc/build)
build dependencies
| pkg | functionality |
| -- | -- |
|  build-essential | c build tools |
|  cmake | c build system          |
|  curl | url commands             |
|  gettext | text manipulation     |
|  git | version control           |
|  liblua5.1-0-dev | plugin dep    |
|  ninja-build | build system      |

### [haskell dependencies](https://www.haskell.org/ghcup/install)
build dependencies
| pkg | functionality |
| -- | -- |
| build-essential | c build tools |
| curl | url commands             |
| libffi-dev & libffi8 |foreign function interface <br> allows binding between compiled and interpreted languages |
| libgmp-dev & libgmp10 | gnu multiple precision math lib   |
| libncurses-dev & libncurses6 | ncurses tui lib |
| libtinfo6 | ncurses character conversion dep  |
| pkg-config | cross platform compiler flag tool |


TODO: add kitty deps, new full list, finish overview and linking

## overview
- shell
    - fish
- editor
    - nvim
- scripts
    - setup
- language setup & dependencies
    - c
    - lua
    - haskell
    - python
    - rust
