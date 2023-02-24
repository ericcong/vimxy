if !has('python3')
    echo "Error: Required vim compiled with +python3"
    finish
endif

function! vimxy#vimxy()
    if exists("g:vimxy_env") && g:vimxy_env == "yaml"
        call vimxy#y2x()
    else
        call vimxy#x2y()
    endif
endfunction

function! vimxy#x2y()
py3 << endpy3
import vim, xmltodict, yaml, re
xml_string_src = "\n".join(vim.current.buffer)
try:
    src_obj = xmltodict.parse(xml_string_src)
    yaml_string_dest = yaml.dump(src_obj, stream=None, Dumper=yaml.Dumper, default_flow_style=False, indent=4, width=999, sort_keys=False)
    yaml_string_dest = re.sub(r'(\n\s+)-   ', r'\g<1>  - ', yaml_string_dest)
    vim.current.buffer[:] = yaml_string_dest.split("\n")
    vim.command("set ft=yaml")
    vim.command("let g:vimxy_env='yaml'")
except:
    print("Incorrect XML format")
endpy3
endfunction

function! vimxy#y2x()
py3 << endpy3
import vim, xmltodict, yaml
yaml_string_src = "\n".join(vim.current.buffer)
try:
    src_obj = yaml.load(yaml_string_src, yaml.SafeLoader)
    xml_string_dest = xmltodict.unparse(src_obj, pretty=True, encoding="UTF-8")
    vim.current.buffer[:] = xml_string_dest.split("\n")
    vim.command("set ft=xml")
    vim.command("let g:vimxy_env='xml'")
except:
    print("Incorrect YAML format")
endpy3
endfunction
