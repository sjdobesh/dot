# dot files

## fast set up

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

includes... 
<dl>
    <dt> curl </dt> <dd> URL interactions         </dd>
    <dt> git  </dt> <dd> version control          </dd>
    <dt> ssh  </dt> <dd> remote shell connection  </dd>
    <dt> vim  </dt> <dd> default text editor      </dd>
</dl>

### networking 
basic linux networking admin tools 

includes...
<dt>iproute2</dt>
<dd>modern tools like ip, ss, iw, tc, supports netlink socket protocol, VLANs, policy routing, etc.       |\</dd>

 <dt>net-tools</dt> 
<dd>legacy tools like ifconfig, route, netstat, etc.</dd>

### c-dev
basic c development tools

includes...  
<dt>bear</dt>
<dd>compilation database generator</dd>
<dt>build-essential</dt> 
<dd>contains all essential c dev tools for unix like gcc/g++, make, and libc </dd>
<dt>clang</dt> 
<dd>llvm based compiler</dd>
<dt>clang-tools</dt>
<dd>llvm utils</dd>
<dt>cmake</dt>
<dd>build system</dd>
<dt>gdb</dt>
<dd>gnu c debugger</dd>
<dt>lldb</dt> 
<dd>llvm debugger</dd>
<dt>valgrind</dt> 
<dd>memory analyzer</dd>

### c-xtra
commonly used c dev libraries
includes...                         
                                    
<dt>libclang-dev</dt>
<dd>clang lib</dd>      
<dt>libncurses-dev</dt>
<dd>tui lib</dd>      
<dt>libpng-dev</dt>
<dd>png format lib</dd>   
<dt>libsdl3-dev</dt> 
<dd>SDL3 graphics lib</dd>
<dt>libsdl3-image-dev</dt>           
<dd>SDL3 img lib for loading images to SDL surfaces or textures</dd>     
 <dt>libsdl3-ttf-dev</dt>              
<dd>SDL3 ttf lib for loading fonts</dd>  
                                
--------------------------------


["NVIM_DEP"]="\
+-[ NEOVIM DEPENDENCIES ]---------------+\
| neovim dependencies                   |\
| https://neovim.io/doc/build           |\
+---------------------------------------+\
| includes...                           |\
|                                       |\
|   - [ build-essential ] c build tools |\
|   - [ cmake ] c build system          |\
|   - [ curl ] url commands             |\
|   - [ gettext ] text manipulation     |\
|   - [ git ] version control           |\
|   - [ liblua5.1-0-dev ] plugin dep    |\
|   - [ ninja-build ] build system      |\
|                                       |\
+---------------------------------------+"


["HASKELL_DEP"]="\
+-[ HASKELL DEPENDENCIES ]--------------+\
| haskell dependencies                  |\
| https://www.haskell.org/ghcup/install |\
+---------------------------------------+\
| includes...                           |\
|   - [ build-essential ] c build tools |\
|   - [ curl ] url commands             |\
|   - [ libffi-dev & libffi8 ]          |\
|     foreign function interface        |\
|     allows binding between compiled   |\
|     and interpreted languages         |\
|   - [ libgmp-dev & libgmp10 ]         |\
|     gnu multiple precision math lib   |\
|   - [ libncurses-dev & libncurses6 ]  |\
|     ncurses tui lib                   |\
|   - [ libtinfo6 ]                     |\
|     ncurses character conversion dep  |\
|   - [ pkg-config ]                    |\
|     cross platform compiler flag tool |\
|                                       |\
+---------------------------------------+"


["PROG_LANGS"]="\
+-[ PROGRAMMING LANGUAGES ]-------------+\
| additional programming languages      |\
+---------------------------------------+\
| includes...                           |\
|                                       |\
|   - [ default-jdk ] java development  |\
|   - [ perl ] just another perl hacker |\
|   - [ python3 ] snek /\\/\\/:<~         |\
|   - [ python3-pip ] package manager   ||


["FULL"]="\
| all other packages                    |\
| includes...                           |\
|                                       |\
|   - [ lsof ]      list open files     |\
|   - [ fdisk ]     format disk         |\
|   - [ feh ]       image viewer        |\
|   - [ figlet ]    ascii art           |\
|   - [ fuse ]      run app images      |\
|   - [ fzf ]       fuzzy finder        |\
|   - [ moreutils ] extra bash tools    |\
|   - [ tcc ]       tiny c compiler     |\
|   - [ rsync ]     directory sync      |\
|   - [ stow ]      symlink manager     |\
|   - [ wget ]      gnu downloader      |\
|   - [ zip ]       file compressor     |\
|   - [ zsh ]       shell               |\

<details><summary> full list </summary>
<ul>
    <li> curl            </li>
    <li> git             </li>
    <li> vim             </li>
    <li> iproute2        </li>
    <li> net-tools       </li>
    <li> bear            </li>
    <li> build-essential </li>
    <li> clang           </li>
    <li> clang-tools     </li>
    <li> cmake           </li>
    <li> gdb             </li>
    <li> lldb            </li>
    <li> valgrind        </li>
    <li> libclang-dev    </li>
    <li> libncurses-dev  </li>
    <li> libpng-dev      </li>
    <li> libsdl3-dev     </li>
    <li> libsdl3-image-dev </li>
    <li> libsdl3-ttf-dev </li>
    <li> gettext         </li>
    <li> ninja-build     </li>
    <li> liblua5.1-0-dev </li>
    <li> libffi-dev      </li>
    <li> libffi8         </li>
    <li> libgmp-dev libgmp10 </li>
    <li> libncurses6     </li>
    <li> libtinfo6       </li>
    <li> pkg-config      </li>
    <li> default-jdk     </li>
    <li> gnucobol        </li>
    <li> perl            </li>
    <li> python3         </li>
    <li> python3-pip     </li>
    <li> debian-goodies  </li>
    <li> lsof            </li>
    <li> fdisk           </li>
    <li> feh             </li>
    <li> figlet          </li>
    <li> fuse            </li>
    <li> fzf             </li>
    <li> moreutils       </li>
    <li> tcc             </li>
    <li> rsync           </li>
    <li> stow            </li>
    <li> wget            </li>
    <li> zip             </li>
</ul>
</details>

<details><summary>cargo packages</summary>

<ul>
    <li> bat             </li>
    <li> eza             </li>
    <li> fd-find         </li>
    <li> ripgrep         </li>
    <li> tealdeer        </li>
    <li> tree-sitter-cli </li>
</ul>
</details>

- shell
    - fish
- editor
    - nvim
- configs
    - stow
    - ssh
    - git
- scripts
    - setup
- language setup & dependencies
    - c
    - lua
    - haskell
    - python
    - rust
