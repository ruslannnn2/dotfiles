return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup({})
    ts.install({
      "astro", "bash", "c", "cmake", "cpp", "css", "fish", "gitignore",
      "go", "graphql", "http", "java", "php", "python", "rust", "scss",
      "sql", "svelte", "html", "javascript", "typescript", "tsx", "json",
      "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "typst",
      "yaml", "toml",
    })

    vim.filetype.add({ extension = { mdx = "mdx" } })
    vim.treesitter.language.register("markdown", "mdx")
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("RusakTreesitter", { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if lang and vim.treesitter.language.add(lang) then
          vim.treesitter.start(args.buf, lang)
        end
      end,
    })
  end,
}
