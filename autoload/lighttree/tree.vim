let s:tree = {}

" import
let s:node = "lighttree#node"

function! lighttree#tree#new(opt = {}) abort
    let this = copy(s:tree)
    let this.id = lighttree#MakeId('tree')
    let this.name = get(a:opt, 'name', 'Tree'..this.id)
    let this.node_list = get(a:opt, 'node_list', [])
    let this.root = get(a:opt, 'root', {s:node}#newRoot({'name': this.name}))
    let this.node_open = get(a:opt, 'node_open', [])
    let this.renderer = ''

    return this
endfunction

function! s:tree.Render() abort
    "TODO
endfunction

function! s:tree.AddNode() abort
    "TODO
endfunction

function! s:tree.RemoveNode() abort
    "TODO
endfunction

function! s:tree.FoldAll() abort
    "TODO
endfunction

function! s:tree.UnfoldAll() abort
    "TODO
endfunction
