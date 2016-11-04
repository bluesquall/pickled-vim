call pathogen#infect()

" Section: configuration

  scriptencoding utf-8

  " some useful bits to encourage lines < 80 characters
  set colorcolumn=76
  " set textwidth=80

  " let's try solarized
  set background=dark
  colorscheme solarized
  let g:solarized_termtrans=1
  " colorscheme atom-dark

  " make sure we can select without entering visual mode
  " (enables easier copying to other applications)
  set mouse-=a

  " let's give vim an easy way to insert timestamps
  nnoremap <F5> "=strftime("%F %T-%z")<CR>P
  inoremap <F5> "=strftime("%F %T-%z")<CR>P

  " These two enable syntax highlighting
  set nocompatible          " We're running Vim, not Vi!
  syntax on                 " Enable syntax highlighting

  " Enable filetype-specific indenting and plugins
  filetype plugin indent on

  " show the `best match so far' as search strings are typed
  set incsearch

  " Highlight search results once found:
  set hlsearch

  " highlight the current line the cursor is on
  set cursorline
  " highlight the current column the cursor is on
  "set cursorcolumn

  "sm:    flashes matching brackets or parentheses
  set showmatch

  "sta:   helps with backspacing because of expandtab
  set smarttab

  " Set temporary directory (don't litter local dir with swp/tmp files)
  " set directory=/tmp/ 
  " ^ caused a headache when the netbook didn't sleep and I lost my .swp
  set backupdir=~/tmp/vim/
  set directory=~/tmp/vim/

  " When scrolling off-screen do so 3 lines at a time, not 1
  set scrolloff=3

  " enable line numbers 
  set number
  setlocal numberwidth=3

  " Enable tab complete for commands.
  " first tab shows all matches. next tab starts cycling through the matches
  set wildmenu
  set wildmode=list:longest,full

  " don't complete from included files, on account of slow
  set complete-=i

  " Display extra whitespace
  set list listchars=tab:»·,trail:·

  " don't make it look like there are line breaks where there aren't:
  set nowrap

  " assume the /g flag on :s substitutions to replace all matches in a line:
  " set gdefault

  " Nice statusbar
  set laststatus=2
  set statusline=\ "
  set statusline+=%f\ " file name
  set statusline+=[
  set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
  set statusline+=%{&fileformat}] " file format
  set statusline+=%h%1*%m%r%w%0* " flag
  set statusline+=%= " right align
  set statusline+=%-14.(%l,%c%V%)\ %<%P " offset

  " enable setting title
  set title
  " configure title to look like: Vim /path/to/file
  set titlestring=VIM:\ %-25.55F\ %a%r%m titlelen=70

  " Make backspace work in insert mode
  set backspace=indent,eol,start

  " can has foldin plz?
  set foldenable
  set foldmethod=syntax
  set foldlevel=999 " make it really high, so they're not displayed by default
  
  " 'murica
  set spelllang=en_us
  
  augroup myfiletypes
    " Clear old autocmds in group
    autocmd!
    " autoindent with two spaces, always expand tabs
    autocmd FileType ruby,eruby,yaml,markdown set autoindent shiftwidth=2 softtabstop=2 tabstop=2 expandtab
    autocmd FileType python set autoindent shiftwidth=4 softtabstop=4 expandtab textwidth=80
    autocmd FileType matlab set autoindent shiftwidth=4 softtabstop=4 expandtab textwidth=80
    autocmd FileType c,cpp set autoindent shiftwidth=4 softtabstop=4 expandtab
    " add for LaTeX files
    autocmd FileType javascript,html,htmldjango,css set autoindent shiftwidth=2 softtabstop=2 expandtab
    autocmd FileType vim set autoindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab
    autocmd FileType cucumber set autoindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab
    autocmd FileType puppet set autoindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab
    au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
    au BufRead,BufNewFile *etc/nginx/* set ft=nginx 
    " treat rackup files like ruby
    au BufRead,BufNewFile *.ru set ft=ruby
    au BufRead,BufNewFile Gemfile set ft=ruby
    autocmd BufEnter *.haml setlocal cursorcolumn
    au BufRead,BufNewFile Gemfile set ft=ruby                                   
    au BufRead,BufNewFile Capfile set ft=ruby                                   
    au BufRead,BufNewFile Thorfile set ft=ruby                                   
    au BufRead,BufNewFile *.god set ft=ruby  
    au BufRead,BufNewFile .caprc set ft=ruby  
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
  augroup END


  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endi

  " Turn on language specific omnifuncs
  autocmd FileType ruby set omnifunc=rubycomplete#Complete
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
  autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP
  autocmd FileType c set omnifunc=ccomplete#Complete

" Section: functions

  function! s:RunShellCommand(cmdline)
    botright new

    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nobuflisted
    setlocal noswapfile
    setlocal nowrap
    setlocal filetype=shell
    setlocal syntax=shell

    call setline(1,a:cmdline)
    call setline(2,substitute(a:cmdline,'.','=','g'))
    execute 'silent $read !'.escape(a:cmdline,'%#')
    setlocal nomodifiable
    1
  endfunction

" Section: commands

  " Shell
  command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)

" Section: mappings

  " Tab navigation
  nmap <leader>tn :tabnext<CR>
  nmap <leader>tp :tabprevious<CR>
  nmap <leader>te :tabedit

  " Remap F1 from Help to ESC.  No more accidents.
  nmap <F1> <Esc>
  map! <F1> <Esc>

  " <leader>F to begin searching with ack
  map <leader>F :Ack<space>

  " search next/previous -- center in page
  nmap n nzz
  nmap N Nzz
  nmap * *Nzz
  nmap # #nzz

  " Yank from the cursor to the end of the line, to be consistent with C and D.
  nnoremap Y y$

  " Hide search highlighting
  map <silent> <leader>nh :nohls <CR>

  " Easily spell check
  " http://vimcasts.org/episodes/spell-checking/
  nmap <silent> <leader>s :set spell!<CR>
  

  map <C-c>n :cnext<CR>
  map <C-c>p :cprevious<CR>

