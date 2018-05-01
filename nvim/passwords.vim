highlight Password ctermfg=252 ctermbg=252 guibg=orange guifg=orange

augroup CPT
au!
au BufReadPre passwords.txt set bin viminfo= noswapfile

au BufReadPost passwords.txt let $vimpass = inputsecret("Password: ")
au BufReadPost passwords.txt silent '[,']!ccrypt -cb -E vimpass
au BufReadPost passwords.txt set nobin
au BufReadPost passwords.txt call matchadd('Password', '\v  \zs([^ ]+)\ze( +; .*|$ )')

au BufWritePre passwords.txt set bin
au BufWritePre passwords.txt '[,']!ccrypt -e -E vimpass

au BufWritePost passwords.txt u
au BufWritePost passwords.txt set nobin
augroup END
