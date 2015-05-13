# vimxy
A Vim plugin for editing XML file in YAML fashion

# Installation
This plugin depends on two Python libraries:
- [xmltodict](https://github.com/martinblech/xmltodict)
- [PyYaml](https://github.com/yaml/pyyaml)

So first it's necessary to install these libraries by:

`pip install xmltodict PyYaml`

Then if [Vundle](https://github.com/gmarik/Vundle.vim) is installed, just add:

`Bundle "ericcong/vimxy"`

in your vimrc, then run `:PluginInstall`

# Basic Usage
- Run `:Vimxy` to convert XML file in the buffer into YAML
- Run `:UnVimxy` to convert the YAML file back to XML