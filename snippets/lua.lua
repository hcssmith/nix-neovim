local ls = require("luasnip")
local s = ls.snippet
local c = ls.c
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
  s({
      trig = "lazy",
      desc = "Basic lazy plugin spec."
    },
    fmt([[
    ---@type LazyPluginSpec
    return {{
      '{repo_name}',
      {opts}
      {config}
    }}
    ]], {
      repo_name = i(1, 'Plugin Repo'),
      opts = c(2, {
        t('opts = {},'),
        fmt([[
          opts = function ()
            {define}
            return {{
              {body}
            }}
          end,
        ]],
          {
            define = i(1, '--Opts Defines'),
            body = i(2, '--Opts Body')
          }
        ),
        t('')
      }),
      config = c(3, {
        t(''),
        fmt([[
          config = function(_, opts)
            require('{req}').setup({{opts}})
            {body}
          end
        ]],
          {
            req = i(1, 'main'),
            body = i(2, '--body')
          }
        )
      })
    }
    )
  ),
}
