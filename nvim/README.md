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

|    Key  | Function                            | Source                    |
|:-------:|:----------------------------------- |:-------------------------:|
|   F01   | Help screen (built-in)              | Built-in                  |
|   F02   | Query current item (Shift for tupe) | Trouble                   |
|   F03   | File browser                        | Nvim-Tree                 |
|   F04   | *Unclaimed*                         | *Unused*                  |
| **F05** | Build (Ctrl for clean)              | Filetype related          |
| **F06** | Preview                             | Filetype related          |
|   F07   | Log screen                          | Lspconfig                 |
|   F08   | Errors and warnings (Shift for all) | Trouble                   |
|   F09   | Snippets                            | UltiSnips                 |
|   F10   | *Unclaimed*                         | *Unused*                  |
|   F11   | *Unclaimed*                         | *Unused*                  |
|***F12***| This is reserved for dropdown term  | ***OS***                  |
