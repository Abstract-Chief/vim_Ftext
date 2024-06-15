let g:VimBaseTextUserPath=expand('~')."/.VimTextStorage/"
let g:VimBaseTextCommenter="$"
function! _GetTypeFromName(name)
   let l:len=strlen(a:name)
   for i in range(0,l:len)
      if a:name[l:len-i]=="."
         return a:name[l:len-i+1:]
      endif
   endfor
   return "null"
endfunction
function! _GetNameFromBuf(str,type)
   let l:res=split(a:str,"/")
   if a:type==1
      return l:res[len(l:res)-1]
   else
      let l:res=str2list(l:res[len(l:res)-1])
      let l:len=len(l:res)
      for i in range(0,l:len-1)
         if l:res[i]==46
            let l:res[i]=95
         endif
      endfor
      return list2str(l:res)
   endif
endfunction
function! _FolderExist(folder)
    let l:folder = fnamemodify(a:folder, ':p')
    return !empty(l:folder) && isdirectory(l:folder)
endfunction
function! _CheckCreateBaseStorage()
   if _FolderExist(g:VimBaseTextUserPath)==0
      call mkdir(g:VimBaseTextUserPath,'p')
   endif
endfunction

function! _GetBaseText(type)
   let l:type=_GetTypeFromName(bufname())
   if filereadable(g:VimBaseTextUserPath."pattern_".bufname().".pat")
      let l:file=readfile(g:VimBaseTextUserPath."pattern_".bufname().".pat")
      return l:file
   elseif filereadable(g:VimBaseTextUserPath."pattern.".l:type.".pat")
      let l:file=readfile(g:VimBaseTextUserPath."pattern.".l:type.".pat")
      return l:file
   endif
   return []
endfunction

function! _CompliteLineBase(line,symbols)
   if a:line==""
      return " "
   endif
   for i in a:line
      if i!=' ' && i!=g:VimBaseTextCommenter
         break
      elseif i==g:VimBaseTextCommenter
         return ""
      endif
   endfor
   let l:result=a:line
   for i in keys(a:symbols)
      let l:result=substitute(l:result,i,a:symbols[i],"")
      let l:result=substitute(l:result,toupper(i),toupper(a:symbols[i]),"")
   endfor
   return l:result
endfunction

function! _CompliteBaseText(list,symbols)
   let l:result=[]
   for i in range(0,len(a:list)-1)
      let l:obj=_CompliteLineBase(a:list[i],a:symbols)
      if l:obj!=""
         call add(l:result,l:obj)
      endif
   endfor
   return l:result
endfunction
function! _AutoCommandSetBaseText()
   let l:SymbolName={"%name": _GetNameFromBuf(bufname(),0),"%pname": _GetNameFromBuf(bufname(),1),"%uname":toupper(_GetNameFromBuf(bufname(),0)),"%type": _GetTypeFromName(bufname()),"%user": $USER,"%date1": strftime("%c"),                    "%date2":strftime('%Y-%m-%d'),"%date3":strftime('%A'),"%time":strftime("%H:%M")}
   let l:list=_GetBaseText(l:SymbolName["%type"])
   if l:list==[]
      return 0
   endif
   let l:new_list = _CompliteBaseText(l:list,l:SymbolName)
   let l:user_pos=[0,0]
   for i in range(0,len(l:new_list)-1)
      let l:mr=matchend(l:new_list[i],"%pos")
      if l:mr>=0
         let user_pos=[i+1,l:mr-3]
         let l:new_list[i]=substitute(l:new_list[i],"%pos","","g")
      endif
      call setline(i+1,l:new_list[i])
   endfor
   call cursor(l:user_pos[0],l:user_pos[1])
   return 1
endfunction

function! _SetInfoInPattern()
   if getfsize(expand("%:p"))!=0
      return 1
   endif
   let l:cc=g:VimBaseTextCommenter
   call setline(1,"")
   call setline(2,"")
   call setline(3,l:cc."dynamic operators -> %name <filename_type>  %pname <filename.type>")
   call setline(4,l:cc."                     %type <type> %user <username> %time <12:56>")
   call setline(5,l:cc."                     %date1 <Mon 01 Apr 2024 12:53:10 PM CEST>")
   call setline(6,l:cc."                     %date2 <2024-04-1> %date3 <Monday>")
   call setline(7,l:cc."                     %pos --set cursor on last %pos in file")
endfunction
function! SetBaseTextFull()
   call _CheckCreateBaseStorage()
   execute 'sp '.g:VimBaseTextUserPath."pattern_".bufname().".pat"
   call _SetInfoInPattern()
endfunction

function! SetBaseText()
   let l:type=_GetTypeFromName(bufname())
   call _CheckCreateBaseStorage()
   execute 'sp '.g:VimBaseTextUserPath."pattern.".l:type.".pat"
   call _SetInfoInPattern()
endfunction
autocmd BufNewFile * :call _AutoCommandSetBaseText()











