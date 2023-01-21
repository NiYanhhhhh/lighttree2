let g:LighttreeLog = {}

function! g:LighttreeLog.log(log, type) abort
    exec "echohl " .. a:type
    echo printf("[lighttree] %s", a:log)
    echohl None
endfunction

function! g:LighttreeLog.error(err) abort
    call g:LighttreeLog.log(a:err, "ErrorMsg")
endfunction

function! g:LighttreeLog.warn(warn) abort
    call g:LighttreeLog.log(a:warn, "WarningMsg")
endfunction

function! g:LighttreeLog.info(info) abort
    call g:LighttreeLog.log(a:info, "String")
endfunction
