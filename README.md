# luaueb
_spelled as Loua Oueb_

## Purpose
It's for generating web sites, in less than 100 lines of Lua.

More exactly, generating web pages with pattern replacing.

It's useful if you have a static website, in several languages.

## Prerequisite
You must have Lua installed.

It should work with all flavors of Lua if > 5.1 .

## Files needed
Prepare a directory _templates_ containing your sources files and the patterns files.

A source file has a **.tpl** extension.

Pattern files have the same basename than source file, with language as extension.

#### Example
filename | contains
-----|-----
_templates/foo.tpl_|template file (classical html, with patterns to insert)
_templates/foo.en_|patterns file (english)
_templates/foo.fr_|patterns file (french)


## Grammar
A template file will contain a list of patterns name, followed by text to insert.

```
[pattern 1]
This text will replace the above pattern in the associated template file.
[foobar]
Same for this one, and so on.
```

Links in template file must be written with a **.tpl** suffix.

That is : `<a href="foo.tpl">foo</a>` will become after generation _foo.en.html_ and _foo.fr.html_ , depending of generated file.

## Full sample

See the _templates_ directory for a full sample.


## How to generate output
When _templates_ directory is ready, launch `./luaweb` and here you go.


## Output location
Generated files will be found in _final_ subdirectories.

If _final_ doesn't exist, it is created.
