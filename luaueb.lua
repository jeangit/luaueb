#!/usr/bin/env lua
-- $$DATE$$ : ven. 25 janvier 2019 (10:16:27)

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
  end

  ---[[ test du dictionnaire
  for i,v in pairs(dico["index.en"]) do
    print(i,v)
  end
  --]]

end

main()
