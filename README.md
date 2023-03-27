# `hex-static.nvim`

This plugin simply exposes one command `:HexStringToCArray` that does exactly
what you think it does: it turns a hexstring into a C-style array of bytes. For
instance it will turn:

```
01AA44684200
```

into

```
0x01, 0xAA, 0x44, 0x68, 0x42, 0x00
```

In normal mode, it will try and convert the current line. In visual mode
it will try to convert the selected text. If convertion fail, the command
will fail and display an error message in the `:messages`.

## Installation

For [Lazy](https://github.com/folke/lazy.nvim), simply add this plugin spec
to your config:

```lua
{
    "meuter/hex-static.nvim",
    config = function()
        require("hex-static").setup()
    end
}
```

or even shorter:

```lua
{
    "meuter/hex-static.nvim",
    config = true
}
```
