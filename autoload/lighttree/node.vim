"Factory
function! lighttree#node#new(opt = {}) abort
    let this = {}
    let this.id = lighttree#MakeId('node')
    let this.type = get(a:opt, 'type', 'node')
    let this.name = get(a:opt, 'name', this.type .. this.id)

    return this
endfunction

" class Node
"===========
let s:node = {}
function! lighttree#node#newNode(opt = {}) abort
    let this = lighttree#node#new(a:opt)
    let this.name = get(a:opt, 'name', 'Node'..this.id)
endfunction

function! s:node.AddChild() abort
    "TODO
endfunction

" class Root extend Node
"=======================
function! lighttree#node#newRoot(opt = {}) abort
    let this = lighttree#node#new(a:opt)
    let this.type = 'root'
endfunction

" class Leaf
"===========
function! lighttree#node#newLeaf(opt = {}) abort
    let this = lighttree#node#new(a:opt)
endfunction
