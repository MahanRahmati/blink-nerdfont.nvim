# blink-nerdfont.nvim

A nerd font source for [blink.cmp](https://github.com/Saghen/blink.cmp).

## 🎨 Features

- Trigger on colon `:`.
- Ghost text completion support.

## 🔨 Installation

### 💤 lazy.nvim

```lua
{
  "saghen/blink.cmp",
  dependencies = {
      "MahanRahmati/blink-nerdfont.nvim",
  },
  opts = {
    sources = {
      default = {
        ...
        "nerdfont",
      },
      providers = {
        nerdfont = {
          module = "blink-nerdfont",
          name = "Nerd Fonts",
          score_offset = 15, -- Tune by preference
          opts = { insert = true }, -- Insert nerdfont icon (default) or complete its name
        }
      }
    }
  }
}
```

## 📘 Usage

Press `:`.

## 💪 Credit

Based on [chrisgrieser/cmp-nerdfont](https://github.com/chrisgrieser/cmp-nerdfont) and [moyiz/blink-emoji.nvim](https://github.com/moyiz/blink-emoji.nvim)

## 📜 License

See [License](./LICENSE).

