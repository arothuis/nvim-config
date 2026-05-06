return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "html", "css", "scss", "less",
    "javascript", "javascriptreact", "typescript", "typescriptreact",
    "svelte", "clojure", "clojurescript",
  },
  root_markers = {
    "tailwind.config.js", "tailwind.config.ts",
    "tailwind.config.mjs", "tailwind.config.cjs",
    "postcss.config.js", "postcss.config.ts",
    "package.json",
  },
  settings = {
    tailwindCSS = {
      includeLanguages = {
        clojure = "html",
        clojurescript = "html",
      },
      experimental = {
        classRegex = {
          { ":class\\s+\"([^\"]*)\"" },
          { ":class\\s+\\[([^\\]]*)\\]", "\"([^\"]*)\"" },
          { ":[\\w-]+\\.([\\w./-]+)" },
          { "\\[([^\\]]*)\\]", "\"([^\"]*)\"" },
        },
      },
    },
  },
}
