let g:lighttreeLog = {}

function! g:lighttreeLog.log(log, type) abort
    exe "echohl " .. a:type
    echo printf("[lighttree] %s", a:log)
    echohl None
endfunction

function! g:lighttreeLog.error(err) abort
    call g:lighttreeLog.log(a:err, "ErrorMsg")
endfunction

function! g:lighttreeLog.warn(warn) abort
    call g:lighttreeLog.log(a:warn, "WariningMsg")
endfunction

function! g:lighttreeLog.info(info) abort
    call g:lighttreeLog.log(a:info, "String")
endfunction
