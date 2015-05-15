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
Run `:Vimxy` to toggle XML and YAML mode

If `filetype` is `XML` then change to corresponding YAML, if it's `YAML` then change to corresponding XML.