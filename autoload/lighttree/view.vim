let s:views = {}
let s:treeView = {}

"DOC:
" TreeView
" ========
" View is the first layer. TreeView contains some sources, of which each is a
" tree object. Usually we create the window and buffer first, and the view
" object after. Then we bind the view and buffer by b: variable. See
" |lighttree#file#open|.
function! lighttree#view#newTreeView(name, sources = [], opt = {}) abort
    let this = copy(s:treeView)
    let this.sources = a:sources
    let this.Render = get(a:opt, 'Render', this.Render)

    let s:views[a:name] = this
    return this
endfunction

function! s:treeView.AddSource(tree) abort
    call add(self.sources, a:tree)
    call self.Render(a:tree)
endfunction

"DOC:
" treeView.RemoveSource(tree)
" ===========================
"
function! s:treeView.RemoveSource(tree) abort
    let tree = type(a:tree) == v:t_string ? self.GetSource(a:tree) : a:tree
endfunction

function! s:treeView.GetSource(name) abort
    for tree in self.sources
        if tree.name == a:name
            return tree
        endif
    endfor

    call g:LighttreeLog.warn('No source named '..a:name)
    return {}
endfunction

"DOC:
" treeView.Render(tree)
" ===============
" This function calls |tree.Render()| to Render the node, so this func just
" renders the tree structure.
function! s:treeView.Render(tree) abort
    for tree in self.sources
    endfor
endfunction

function! s:treeView.GetSource(name) abort
    for tree in self.sources
        let name = get(tree, 'name', '')
        if name == a:name
            return tree
        endif
    endfor
endfunction

" static functions
"=================
function! lighttree#view#CreateBuffer(id = 0) abort
    let buf_id = lighttree#SetId('buffer', a:id, 0)
    let buf_name = "lighttree_" .. buf_id
    exec 'edit '..buf_name

    setlocal bufhidden=hide
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal foldcolumn=0
    setlocal foldmethod=manual
    setlocal nobuflisted
    setlocal nofoldenable
    setlocal nolist
    setlocal nospell
    setlocal nowrap
    setlocal nonumber
    setlocal nocursorcolumn
    if v:version >= 703
        setlocal norelativenumber
    endif

    setlocal filetype=lighttree
    exec "setlocal statusline=[Lighttree]:\\ " .. buf_id
    return bufnr()
endfunction

"DOC:
"
function! lighttree#view#Open(viewType = 'tree', opt = {}) abort
    let last_winnr = winnr()

    let wincmd = get(a:opt, 'wincmd', '')
    let pos = get(a:opt, 'pos', 'left')
    let size = get(a:opt, 'size', [30, 10])
    let IsOccupied = get(a:opt, 'is_occupied', function('lighttree#view#CheckOccupy'))

    if wincmd != ''
        exec wincmd
    else
        call g:LighttreeLog.info('no wincmd')
        if pos == 'top'
            exec 'topleft '.. size[1] .. 'split new'
        elseif pos == 'bottom'
            exec 'botright '.. size[1] .. 'split new'
        else
            if pos == 'left'
                exec 'wincmd t'
                if IsOccupied() | exec size[1] .. 'split new' | else | exec 'topleft vertical ' ..size[0].. ' new' | endif
            elseif pos == 'right'
                exec 'wincmd b'
                if IsOccupied() | exec size[1] .. 'split new' | else | exec 'botright vertical ' ..size[0].. ' new' | endif
            endif
        endif
    endif

    setlocal winfixwidth
    setlocal winfixheight

    let id = get(a:opt, 'id', lighttree#MakeId('buffer'))
    let bufnr = lighttree#view#CreateBuffer(id)

    if !exists('t:lighttree')
        let t:lighttree = {}
    endif

    return win_getid()
endfunction

function! lighttree#view#CheckOccupy() abort
    let pattern = g:lighttree_follow_pattern
    for pa in pattern
        if bufname() =~ pa
            return v:true
        endif
    endfor

    return v:false
endfunction

function! lighttree#view#TreeMap() abort
    nnoremap <buffer> q <cmd>call lighttree#view#CloseWin()<cr>
    nnoremap <buffer> <cr> <cmd>call b:LighttreeView.toggle(line('.'))<cr>
    nnoremap <buffer> <2-leftmouse> <cmd>call b:LighttreeView.toggle(line('.'))<cr>
    nnoremap <buffer> o <cmd>call b:LighttreeView.toggle(line('.'))<cr>
    nnoremap <buffer> s <cmd>call b:LighttreeView.open(line('.'), {'flag': 'v'})<cr>
    nnoremap <buffer> i <cmd>call b:LighttreeView.open(line('.'), {'flag': 'h'})<cr>
    nnoremap <buffer> t <cmd>call b:LighttreeView.open(line('.'), {'flag': 't'})<cr>
    nnoremap <buffer> p <cmd>call b:LighttreeView.focus_node_parent(line('.'))<cr>
    nnoremap <buffer> P <cmd>call b:LighttreeView.focus_node_root(line('.'))<cr>
    nnoremap <buffer> J <cmd>call b:LighttreeView.focus_node_last(line('.'))<cr>
    nnoremap <buffer> K <cmd>call b:LighttreeView.focus_node_first(line('.'))<cr>
    nnoremap <buffer> <c-n> <cmd>call b:LighttreeView.focus_node_middle(line('.'))<cr>
    nnoremap <buffer> <c-j> <cmd>call b:LighttreeView.focus_node_next(line('.'))<cr>
    nnoremap <buffer> <c-k> <cmd>call b:LighttreeView.focus_node_prev(line('.'))<cr>
    nnoremap <buffer> r <cmd>call b:LighttreeView.refresh_node0(line('.'))<cr>
    nnoremap <buffer> R <cmd>call b:LighttreeView.reload_node0(line('.'))<cr>
endfunction

function! lighttree#view#GetAllViews() abort
    return s:views
endfunction

"DOC:
" lighttree#view#Draw(tree)
" ===================
" Used for initiating of view, to render existing trees.
function! lighttree#view#Draw(view) abort
    let view = a:view
    for tree in view.sources
        call view.Render(tree)
    endfor
endfunction

function! lighttree#view#CloseWin() abort
    let winnr = winnr()
    wincmd p
    exec winnr.'wincmd q'
endfunction
