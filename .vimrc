
filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on
call pathogen#helptags()

"Set mapleader
let mapleader = ","
let g:mapleader = ","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>


" This means that you can have unwritten changes to a file and open a new file using :e, 
" without being forced to write or undo your changes first. 
" Also, undo buffers and marks are preserved while the buffer is open. 
" This is an absolute must-have
set hidden

" Also, I like Vim to have a large undo buffer, a large history of commands, 
" ignore some file extensions when completing names by pressing Tab,
" and be silent about invalid cursor moves and other errors.
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" It clears the search buffer when you press ,/
" (Tired of clearing highlighted searches by searching for “ldsfhjkhgakjks")
nmap <silent> ,/ :nohlsearch<CR> 

" This lets you use w!! to do that after you opened the file that requires root privileges
cmap w!! w !sudo tee % >/dev/null


set whichwrap=b,s,<,>,[,]
syntax enable
colo desert
set nu
set guifont=ProggyCleanTT\ 12
set hls
set guioptions-=T "get rid of toolbar
filetype plugin on
set smartindent
set autoindent
set expandtab
set list
set cursorline
set hidden
set listchars=tab:>-,trail:.,nbsp:+
se et ts=8 sw=4 softtabstop=4 smarttab
au BufEnter *.py set sw=4 sts=4 ts=4 et sta ai
nnoremap <silent> <C-N> :bn<CR>
nnoremap <silent> <C-P> :bp<CR>
map <F2> :NERDTreeToggle
map <F3> :py GenerateTags()
map <F4> :cd %:h
map <F5> :!gnome-terminal -e "python2.6 -m pdb %"<CR><CR>
map <F6> :!xterm -hold -e "python2.6 -m pdb % -v"<CR><CR>
map <F11> :se path=.,~/Projects/gamr7/code/app/,~/Projects/gamr7/code/
map <F12> :Align 

" to avoid doing ctrl+c or ESC to exit insert mode
inoremap jj <ESC> 

map œ $
imap œ $
vmap œ $
cmap œ $

let g:Tb_MaxSize = 40
let g:Tb_VSplit = 40
let g:Tb_MoreThanOne = 1


let g:delimitMate_apostrophes = ''
"map <leader>t :FuzzyFinderTextMate<CR>

""""""""""""""""""""""""""""""
" Python section
""""""""""""""""""""""""""""""

"Python iMaps
" au FileType python set cindent
au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $s self
au FileType python inoremap <buffer> $c ##<cr>#<space><cr>#<esc>kla
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $d """<cr>"""<esc>O
au FileType python inoremap <buffer> $ss self.

" encrypt/decrypt gcf on the fly
autocmd BufReadPre,FileReadPre      *.gcf set bin modifiable
autocmd BufReadPost,FileReadPost    *.gcf '[,']!python $GAMR7_DEVCODE_PATH/code/gamr7_lib/security/gcf_converter.py --decrypt <afile>
autocmd BufReadPost,FileReadPost    *.gcf set nobin
autocmd BufWritePost,FileWritePost  *.gcf !python $GAMR7_DEVCODE_PATH/code/gamr7_lib/security/gcf_converter.py --encrypt <afile>
au BufRead,BufNewFile *.gcf        set filetype=xml 

""""""""""""""""""""""""""""""
"For syntax errors



""""""""""""""""""""""""""""""
" Better 'gf'
python << EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

""""""""""""""""""""""""""""""
" Python section
""""""""""""""""""""""""""""""

"command Rst :!pandoc -f rst -t html % > /tmp/rstprev.html && see /tmp/rstprev.html
""""""""""""" My cscope/vim key mappings
"
" The following maps all invoke one of the following cscope search types:
"
"   's'   symbol: find all references to the token under cursor
"   'g'   global: find global definition(s) of the token under cursor
"   'c'   calls:  find all calls to the function name under cursor
"   't'   text:   find all instances of the text under cursor
"   'e'   egrep:  egrep search for the word under cursor
"   'f'   file:   open the filename under cursor
"   'i'   includes: find files that include the filename under cursor
"   'd'   called: find functions that function under cursor calls
"
" Below are three sets of the maps: one set that just jumps to your
" search result, one that splits the existing vim window horizontally and
" diplays your search result in the new window, and one that does the same
" thing, but does a vertical split instead (vim 6 only).
"
" I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
" unlikely that you need their default mappings (CTRL-\'s default use is
" as part of CTRL-\ CTRL-N typemap, which basically just does the same
" thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
" If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
" of these maps to use other keys.  One likely candidate is 'CTRL-_'
" (which also maps to CTRL-/, which is easier to type).  By default it is
" used to switch between Hebrew and English keyboard mode.
"
" All of the maps involving the <cfile> macro use '^<cfile>$': this is so
" that searches over '#include <time.h>" return only references to
" 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
" files that contain 'time.h' as part of their name).


" To do the first type of search, hit 'CTRL-\', followed by one of the
" cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
" search will be displayed in the current window.  You can use CTRL-T to
" go back to where you were before the search.
"

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>


" Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
" makes the vim window split horizontally, with search result displayed in
" the new window.
"
" (Note: earlier versions of vim may not have the :scs command, but it
" can be simulated roughly via:
"    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>

nmap <C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>


" Hitting CTRL-space *twice* before the search type does a vertical
" split instead of a horizontal one (vim 6 and up only)
"
" (Note: you may wish to put a 'set splitright' in your .vimrc
" if you prefer the new window on the right instead of the left

nmap <C-Space><C-Space>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-Space><C-Space>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space><C-Space>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

map <F3> :py GenerateTags() 
python << EOL
import os
import subprocess
def GenerateTags():
    old_cwd=os.getcwd()
    os.chdir(os.path.expanduser(os.environ['GAMR7_DEVCODE_PATH']))
    cmd = "ctags -R --tag-relative=yes --languages=Python --python-kinds=-i -f $GAMR7_DEVCODE_PATH/tags $GAMR7_DEVCODE_PATH"
    subprocess.Popen(cmd, shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, close_fds=True).stdin
    cmd = "pycscope.py -R $GAMR7_DEVCODE_PATH"
    subprocess.Popen(cmd, shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, close_fds=True).stdin
    os.chdir(old_cwd)
    vim.command("cs add %s" % (os.environ['GAMR7_DEVCODE_PATH'] + '/cscope.out')) 
EOL

set tags=tags;$HOME
cs add $GAMR7_DEVCODE_PATH/cscope.out 


