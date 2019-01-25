#!/usr/bin/env lua
-- $$DATE$$ : ven. 25 janvier 2019 (16:01:45)

require"lfs"

local dico = {}

function get_basenames( path)
  local iter,dirobj = lfs.dir( path)
  local basenames = {}
  for n in iter,dirobj do
    if ".tpl" == string.match(n,"%.tpl$") then
      basenames[#basenames+1] = string.match(n,"[^%.]+")
    end
  end
  return basenames
end

function token_subst ( buffer)
  for lang in pairs(dico) do
    local tr=dico[lang]
    for w in string.gmatch(buffer, "[^%s]+") do
      w = tr[w] or w
      print( w)
    end
  end

end

function read_template( path, file)
  local hf = io.open( path .. "/" .. file .. ".tpl","r")
  local buffer = hf:read( "a")
  hf:close()
  return buffer
end

function store_dictionary_language( path,file)
  dico[file] = {}
  local curr_key=nil
  local hf = io.open(path .. "/" .. file,"r")
  for l in hf:lines() do
    if l == string.match(l,"%[.*%].*$") then
      if curr_key~=nil then dico[file][curr_key]=dico[file][curr_key] .. "</p>" end
      curr_key=l
      dico[file][curr_key]="<p>"
    elseif string.match(l,"^$") and curr_key then
      dico[file][curr_key]=dico[file][curr_key] .. "</p><p>"
    else
      dico[file][curr_key]=dico[file][curr_key] .. l
    end
  end


  dico[file][curr_key]=dico[file][curr_key] .. "</p>"
  hf:close()

end

function store_dictionary( path, basename)
  local iter,dirobj = lfs.dir( path)
  for n in iter,dirobj do
   if basename == string.match(n,"[^%.]+") and
       ".tpl" ~= string.match(n,"%.tpl$") then
          store_dictionary_language(path ,n)
    end
  end
end

function main()
  local path="templates"
  local basenames= get_basenames( path)
  for _,bname in ipairs(basenames) do
    store_dictionary (path, bname)
    local tpl = read_template( path, bname)
    token_subst ( tpl)
  end

  --[[ test du dictionnaire
  for i,v in pairs(dico["index.en"]) do
    print(i,v)
  end
  --]]

end

main()
