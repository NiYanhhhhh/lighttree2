let s:counter_id_buffer = 0
let s:counter_id_tree = 0
let s:counter_id_node = 0

function! lighttree#FindRoot(path = expand('%')) abort
    let root_pattern = g:lighttree_root_pattern
    let path = fnamemodify(a:path, ':p')
    let dirlist = path->split(lighttree#GetSpliter())
    let checklist = []
    for k in reverse(range(expand('~')->split(lighttree#GetSpliter())->len(), len(dirlist)-2+isdirectory(path)))
        call add(checklist, lighttree#GetSpliter()..dirlist[0:k]->join(lighttree#GetSpliter()))
    endfor
    echo checklist
    for dir in checklist
        for pattern in g:lighttree_root_pattern
            if readdir(dir, {name -> name =~ pattern})->len() > 0
                let isban = 0
                for pattern_ban in g:lighttree_root_pattern_ban
                    if readdir(dir, {name -> name =~ pattern_ban})->len() > 0
                        let isban = 1
                        break
                    endif
                endfor
                if !isban
                    return dir
                endif
            endif
        endfor
    endfor

    return getcwd()
endfunction

function! lighttree#GetSpliter() abort
    return (has('win32') || has('win64')) ? "\\" : '/'
endfunction

function! lighttree#GetId(type) abort
    return s:counter_id_{a:type}
endfunction

function! lighttree#MakeId(type) abort
    let s:counter_id_{a:type} += 1
    return s:counter_id_{a:type}
endfunction

function! lighttree#SetId(type, id, warning=1) abort
    let counter = s:counter_id_{a:type}
    if a:id < counter
        if a:warning
            call g:lighttreeLog.warn("Id cannot be set lower")
        endif
        return lighttree#MakeId('buffer')
    else
        return a:id
    endif
endfunction
