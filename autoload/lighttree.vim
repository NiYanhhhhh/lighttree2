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
