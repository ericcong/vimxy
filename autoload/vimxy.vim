if !has('python')
    echo "Error: Required vim compiled with +python"
    finish
endif

function! vimxy#x2y()
python << endpython
import vim, xmltodict, yaml
from collections import OrderedDict
xml_string = "\n".join(vim.current.buffer)
def ordered_dump(data, stream=None, Dumper=yaml.Dumper, **kwds):
    class OrderedDumper(Dumper):
        pass
    def _dict_representer(dumper, data):
        return dumper.represent_mapping(
            yaml.resolver.BaseResolver.DEFAULT_MAPPING_TAG,
            data.items())
    OrderedDumper.add_representer(OrderedDict, _dict_representer)
    return yaml.dump(data, stream, OrderedDumper, **kwds)
try:
    src_obj = xmltodict.parse(xml_string)
    yaml_string = ordered_dump(src_obj, Dumper=yaml.SafeDumper, default_flow_style=False)
    vim.current.buffer[:] = yaml_string.split("\n")
    vim.command("set ft=yaml")
except:
    print("Incorrect XML format")
endpython
endfunction

function! vimxy#y2x()
python << endpython
import vim, xmltodict, yaml
from collections import OrderedDict
yaml_string = "\n".join(vim.current.buffer)
def ordered_load(stream, Loader=yaml.Loader, object_pairs_hook=OrderedDict):
    class OrderedLoader(Loader):
        pass
    def construct_mapping(loader, node):
        loader.flatten_mapping(node)
        return object_pairs_hook(loader.construct_pairs(node))
    OrderedLoader.add_constructor(
        yaml.resolver.BaseResolver.DEFAULT_MAPPING_TAG,
        construct_mapping)
    return yaml.load(stream, OrderedLoader)
try:
    src_obj = ordered_load(yaml_string, yaml.SafeLoader)
    xml_string = xmltodict.unparse(src_obj, pretty=True)
    vim.current.buffer[:] = xml_string.split("\n")
    vim.command("set ft=xml")
except:
    print("Incorrect YAML format")
endpython
endfunction