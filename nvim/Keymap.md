# Neovim

Guide into using my neovim config.

## Leader Key: `space`

Leader key is space for future reference

## Convenience

This is a list of quick functionality that is useful

| Key               | Function                      |
|:-----------------:|:----------------------------- |
| `Leader` + `s`    | Search and replace            |
| `Leader` + `/`    | Turn off search highlight     |
| `Ctrl` `c`        | Copy to clipboard             |
| `Ctrl` `v`        | Paste to cursor/selection     |

## Navigation keys

This is a list of how navigation is set up.

These are all to be prefixed by `Leader`

| Key (after leader)| Function                                      |
|:-----------------:|:--------------------------------------------- |
| `j` `k` `h` `l`   | Navigate through windows                      |
| `Shift` `H` `L`   | Display prev/next buffer in current window    |
| `Shift` `J` `K`   | Display prev/next tab                         |
| `Tab`             | Display active buffers, and switch to sel.    |
| `d`               | Delete this buffer from buffer list           |
| `q`               | Close this window                             |
| `Shift` `Q`       | Close this tab                                |
| `o`               | List possible files, and open it as a buffer  |
| `Shift` `O`       | Open a new empty buffer                       |
| `n`               | Open a new tab                                |
| `,`               | Split the current window into two horizontally|
| `.`               | Split the current window into two vertically  |

## LSP Mappings

These mappings invoke LSP functions.

| Key (after leader)| `vim.lsp.buf`     | Description                       |
|:-----------------:|:-----------------:|:--------------------------------- |
| `c`               | clear\_references | Remove highlights                 |
| `r`               | code\_action      | Select code action at cursor      |
| `w`               | declaration       | Navigate to where item is declared|
| `?`               | definition        | Navigate to where item is defined |
| `f`               | document\_symbol  | List all symbols in quickfix wind.|
| `'`               | hover             | Display hover information         |
| `i`               | implementation    | List implementations of this var. |
| `Shift` `I`       | references        | List all references to the symbol |
| `u`               | incoming\_calls   | List call sites of this symbol    |
| `Shift` `U`       | outgoing\_calls   | List everything called by symbol  |
| `Enter`           | rename            | Changee every occurrence of symbol|
| `a`               | signature\_help   | Display argument info of symbol   |
| `Shift` `A`       | type\_definition  | Navigate to where item type is    |

## Function Keys : Specific functionality

This is a list of what function keys I use for vim.
(where bold indicates type-specific function)

* First four function keys are dedicated to visual and layout.

|   Key   | Mod | Function                      | Source                    |
|:-------:|:---:|:----------------------------- |:-------------------------:|
|   F01   |     | **Help**: Main documentation  | Built-in                  |
|   F01   | וּ   | LSP: Definition               | `Trouble`                 |
|   F01   |   ﴱ | LSP: References               | `Trouble`                 |
|   F01   | וּ ﴱ | LSP: Type help                | `Trouble`                 |
|   F02   |     | **Hints** keymap cheetsheet.  | `which-key.nvim`          |
|   F02   | וּ   | ***UNCLAIMED***               | ` `                       |
|   F02   |   ﴱ | LSP status                    | `lspconfig`               |
|   F02   | וּ ﴱ | LSP Install status            | `lsp-installer`           |
|   F03   |     | **Graphical** Dim inactive    | `Twilight` + `TreeSitter` |
|   F03   | וּ   | Ataraxis mode                 | `TrueZen`                 |
|   F03   |   ﴱ | ***UNCLAIMED***               | ` `                       |
|   F03   | וּ ﴱ | Browse colorschemes           | `Telescope`               |
|   F04   |     | **Menus**: File browser       | `Nvim-Tree`               |
|   F04   | וּ   | Errors (All buffers)          | `Trouble`                 |
|   F04   |   ﴱ | Symbols outline               | `symbols-outline.nvim`    |
|   F04   | וּ ﴱ | ***UNCLAIMED***               | ` `                       |

* The next four function keys are functionality.

|   Key   | Mod | Function                      | Source                    |
|:-------:|:---:|:----------------------------- |:-------------------------:|
|   F05   |     | **Build**: Run code of doc.   | Filetype specific         |
|   F05   | וּ   | Preview code                  | Filetype specific         |
|   F05   |   ﴱ | Run code subsection           | Filetype specific         |
|   F05   | וּ ﴱ | Clean the build               | Filetype specific         |
|   F06   |     | **Comments**: Comment out     | Filetype specific         |
|   F06   | וּ   | Uncomment this block          | ` `                       |
|   F06   |   ﴱ | Auto-indent                   | ` `                       |
|   F06   | וּ ﴱ | ***UNCLAIMED***               | ` `                       |
|   F07   |     | **Git**: ***UNCLAIMED***      | ` `                       |
|   F07   | וּ   | ***UNCLAIMED***               | ` `                       |
|   F07   |   ﴱ | ***UNCLAIMED***               | ` `                       |
|   F07   | וּ ﴱ | ***UNCLAIMED***               | ` `                       |
|   F08   |     | **Autocomplete**: Quickfix    | LSP Specific              |
|   F08   | וּ   | Snippets                      | `UltiSnips`               |
|   F08   |   ﴱ | Toggle autocomplete           | `nvim-cmp`                |
|   F08   | וּ ﴱ | ***UNCLAIMED***               | ` `                       |

Rest of the function keys are reserved for OS use.
