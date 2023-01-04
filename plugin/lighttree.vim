if !exists('g:lighttree_root_pattern')
    let g:lighttree_root_pattern = ['.git', 'README\.\?\w*', 'LICENSE']
endif

if !exists('g:lighttree_root_pattern_ban')
    let g:lighttree_root_pattern_ban = []
endif

if exists('g:root_pattern')
    let g:lighttree_root_pattern = g:root_pattern
endif

if exists('g:root_pattern_ban')
    let g:lighttree_root_pattern_ban = g:root_pattern_ban
endif
