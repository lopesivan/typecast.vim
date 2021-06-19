"==============================================================
"    file: typecast.vim
"   brief:
" VIM Version: 8.0
"  author: tenfy
"   email: tenfy@tenfy.cn
" created: 2018-09-26 15:16:21
"==============================================================

let s:last_cast_type = ''

nnoremap <silent> <plug>typecast_repeat .

function! typecast#opfunc(type, ...) abort
  let cast_type = <SID>input_type()
  call typecast#do(a:type, cast_type, "'[", "']")
  silent! call repeat#set("\<plug>typecast_repeat"."\<cr>")
endfunction

function! typecast#visual() abort
  let cast_type = <SID>input_type()
  call typecast#do('', cast_type, "'<", "'>")
endfunction

function! typecast#do(type, cast_type, begin_pos_expr, end_pos_expr) abort
  if a:cast_type == ''
    return
  endif
  let s:last_cast_type = a:cast_type

  let begin_pos = getpos(a:begin_pos_expr)
  let end_pos = getpos(a:end_pos_expr)

  let save_selection = &selection

  let save_reg = @@

  let braces_open  = '('
  let braces_close = ')'

  if s:last_cast_type[len(s:last_cast_type)-1] == "("
    let braces_open  = '('
    let braces_close = ')'
    let braces_open  = repeat(braces_open, len(s:last_cast_type))
    let braces_close = repeat(braces_close, len(s:last_cast_type))
  endif

  if s:last_cast_type[len(s:last_cast_type)-1] == "{"
    let braces_open  = '{'
    let braces_close = '}'
    let braces_open  = repeat(braces_open, len(s:last_cast_type))
    let braces_close = repeat(braces_close, len(s:last_cast_type))
  endif

  if s:last_cast_type[len(s:last_cast_type)-1] == "<"
    let braces_open  = '<'
    let braces_close = '>'
    let braces_open  = repeat(braces_open, len(s:last_cast_type))
    let braces_close = repeat(braces_close, len(s:last_cast_type))
  endif

  if s:last_cast_type[len(s:last_cast_type)-1] == "["
    let braces_open  = '['
    let braces_close = ']'
    let braces_open  = repeat(braces_open, len(s:last_cast_type))
    let braces_close = repeat(braces_close, len(s:last_cast_type))
  endif

  if s:last_cast_type[len(s:last_cast_type)-1] == "a"
    let braces_open  = '‘'
    let braces_close = '’'
  endif

  if s:last_cast_type[len(s:last_cast_type)-1] == "c"
    let braces_open  = '```'
    let braces_close = '```'
  endif

  if s:last_cast_type[len(s:last_cast_type)-1] == "i"
    let braces_open  = '`'
    let braces_close = "'"
  endif

  if s:last_cast_type[len(s:last_cast_type)-1] == "\""
    let braces_open  = repeat(s:last_cast_type[len(s:last_cast_type)-1], len(s:last_cast_type))
    let braces_close = repeat(s:last_cast_type[len(s:last_cast_type)-1], len(s:last_cast_type))
  endif

  if s:last_cast_type[len(s:last_cast_type)-1] == "`"
    let braces_open  = repeat(s:last_cast_type[len(s:last_cast_type)-1], len(s:last_cast_type))
    let braces_close = repeat(s:last_cast_type[len(s:last_cast_type)-1], len(s:last_cast_type))
  endif

  if s:last_cast_type[len(s:last_cast_type)-1] == "'"
    let braces_open  = repeat(s:last_cast_type[len(s:last_cast_type)-1], len(s:last_cast_type))
    let braces_close = repeat(s:last_cast_type[len(s:last_cast_type)-1], len(s:last_cast_type))
  endif

  if s:last_cast_type[len(s:last_cast_type)-1] == "*"
    let braces_open  = repeat(s:last_cast_type[len(s:last_cast_type)-1], len(s:last_cast_type))
    let braces_close = repeat(s:last_cast_type[len(s:last_cast_type)-1], len(s:last_cast_type))
  endif

  if s:last_cast_type[len(s:last_cast_type)-1] == "_"
    let braces_open  = repeat(s:last_cast_type[len(s:last_cast_type)-1], len(s:last_cast_type))
    let braces_close = repeat(s:last_cast_type[len(s:last_cast_type)-1], len(s:last_cast_type))
  endif

  " if s:last_cast_type[len(s:last_cast_type)-1] == "\""
  "   if s:last_cast_type[len(s:last_cast_type)-2] == "\""
  "     let braces_open  = '"'
  "     let braces_close = '"""'
  "   else
  "     let braces_open  = ''
  "     let braces_close = '"'
  "   endif
  " endif

  " if s:last_cast_type[len(s:last_cast_type)-1] == "'"
  "   let braces_open  = ''
  "   let braces_close = '\''
  " endif

  " if s:last_cast_type[len(s:last_cast_type)-1] == "*"
  "   if s:last_cast_type[len(s:last_cast_type)-2] == "*"
  "     let braces_open  = ''
  "     let braces_close = '**'
  "   else
  "     let braces_open  = ''
  "     let braces_close = '*'
  "   endif
  " endif

  " if s:last_cast_type[len(s:last_cast_type)-1] == "_"
  "   if s:last_cast_type[len(s:last_cast_type)-2] == "_"
  "     let braces_open  = ''
  "     let braces_close = '__'
  "   else
  "     let braces_open  = ''
  "     let braces_close = '_'
  "   endif
  " endif

  call setreg('"', braces_close, 'v')
  call setpos('.', end_pos)
  normal! ""p

  "call setreg('"', s:last_cast_type . braces_open, 'v')
  call setreg('"', braces_open, 'v')
  call setpos('.', begin_pos)
  normal! ""P

  let @@ = save_reg

  let &selection = save_selection
endfunction

function! s:input_type()
  return input('cast to type: ', s:last_cast_type)
endfunction
