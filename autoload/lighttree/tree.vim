let tree = {}

function! lighttree#tree#new(name = '') abort
    tree.name = a:name
    return tree
endfunction

function tree.getName() abort
    return self.name
endfunction
