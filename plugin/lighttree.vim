" --global define-- "
let g:lighttree_root_pattern = get(g:, 'lighttree_root_pattern',
            \ get(g:, 'root_pattern', ['.git', 'README\.\?\w*', 'LICENSE']))
let g:lighttree_root_pattern_ban = get(g:, 'lighttree_root_pattern_ban',
            \ get(g:, 'root_pattern_ban', []))
let g:lighttree_follow_pattern = get(g:, 'lighttree_follow_pattern', ['^lighttree_\d\+', '^NvimTree_\d\+', '^\[coc-explorer\]-\d\+'])


