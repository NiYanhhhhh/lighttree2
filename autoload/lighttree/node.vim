" class Node
"===========
let s:node = {}

function! lighttree#node#new(opt = {}) abort
    let this = copy(s:node)
    let this.id = lighttree#MakeId('node')
    let this.type = get(a:opt, 'type', 'node')
    let this.name = get(a:opt, 'name', this.type .. this.id)

    let this.has_parent = this.type == 'root' ? 0 : 1
    let this.has_child  = this.type == 'leaf' ? 0 : 1

    call extend(this, a:opt, 'keep')
    return this
endfunction

function! s:node.AddChildren() abort
    if !self.has_child
        call g:LighttreeLog.warn('This node cannot add children:'..self.name..' id:'..self.id)
    endif
    "TODO
endfunction

function! s:node.RemoveChildren() abort
    "TODO
endfunction

function! s:node.ChangeTypeTo(type) abort
    "TODO
endfunction

function! s:node.SetParent() abort
    "TODO
endfunction

function! s:node.Render() abort
    "TODO
endfunction
