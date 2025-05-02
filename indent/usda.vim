" Vim indent file
" Language:         OpenUSD ASCII (.usda)
" Author:           Takayoshi Matsumoto <yamahigashi@gmail.com>
" Last Change:      2025-05-02
" For bugs, patches and license go to https://github.com/yamahigashi/usda.vim

if exists('b:did_indent')
  finish
endif
let b:did_indent = 1


function! UsdaIndent() abort
  " 
  let pline = prevnonblank(v:lnum - 1)
  if pline == 0
    return 0
  endif

  " `}` or `)` should be outdented.
  if getline(v:lnum) =~# '^\s*[})]'
    return indent(pline) - &shiftwidth
  endif

  " `{` or `(` should be indented.
  if getline(pline) =~ '{\s*$' && getline(pline) !~ '{.*}\s*$'
    return indent(pline) + &shiftwidth
  endif
  if getline(pline) =~ '(\s*$' && getline(pline) !~ '.*)\s*$'
    return indent(pline) + &shiftwidth
  endif

  " `[` or `]` should be indented.
  return indent(pline)
endfunction

setlocal indentexpr=UsdaIndent()
setlocal indentkeys=o,O,},),0],0#
