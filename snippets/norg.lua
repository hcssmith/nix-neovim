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

local function day_entry(_, _, _)
  return os.date('%Y-%m-%d')
end

local function generate_link(args, _, _)
  local product = ({
    ['Access Recruit'] = 'Access%20Recruit',
    ['Access TeamSeer'] = 'Access%20TeamSeer',
    ['Access SafePay'] = 'Access%20SafePay',
    ['Access Workspace'] = 'Access%20Workspace',
    ['Access FinOps'] = 'Access%20FinOps',
    ['Access Engage'] = 'Access%20Engage',
  })[args[2][1]] or ''
  return '[' ..
      args[1][1] .. ']{https//dev.azure.com/access-devops/' .. product .. '/_workitems/edit/' .. args[1][1] .. '}'
end


return {
  s({
      trig = 'issue',
      desc = 'Case Notes'
    },
    fmt([[
  * {case_number}
    - {customer}
    - {desc}
    - ( ) {task}
  ]],
      {
        case_number = i(1, 'Case Number'),
        customer = i(2, 'Customer Name'),
        desc = i(3, 'Issue Description'),
        task = i(4, 'First Task')
      }
    )),
  s({
      trig = 'day_entry',
      desc = 'New day entry.',
    },
    fmt([[- {{:{day}:}}]],
      {
        day = f(day_entry)
      }
    )
  ),
  s({
      trig = 'devops',
      desc = 'Dev Ops notes'
    },
    fmt([[
  * {ref}
    - {product}
    - Link: {link}
    - {desc}
    - ( ) {task}
  ]],
      {
        ref = i(1, 'DevOps Reference'),
        link = f(generate_link, { 1, 2 }),
        product = c(2, {
          t('Access Recruit'),
          t('Access TeamSeer'),
          t('Access SafePay'),
          t('Access Workspace'),
          t('Access FinOps'),
          t('Access Engage'),
        }),
        desc = i(3, 'Issue Description'),
        task = i(4, 'First Task')
      }
    )),
  s({
      trig = 'sales_opp',
      desc = 'Sales Opp Template',
    },
    fmt([[
        Customer: {customer}
      Case Number: {ref}
      Problem: {subj}
      Support Investigation Conclusions: {conclusion}
      Impact: {impact}
      Resolution Required By: {due}
      Reason why Support are unable to continue the resolution of this case: {reason}
      Recommended course of action required or help needed to progress: {actions}
    ]],
      {
        customer = i(1, 'Customer Account Name'),
        ref = i(2, 'Case Reference'),
        subj = i(3, 'What is the problem'),
        conclusion = i(4, 'What have we found'),
        impact = c(5, {
          fmt('High: {reason}', { reason = i(1, 'reason for impact') }),
          fmt('Medium: {reason}', { reason = i(1, 'reason for impact') }),
          fmt('Low: {reason}', { reason = i(1, 'reason for impact') }),
        }),
        due = i(6, 'When does this need to be done why'),
        reason = c(7, {
          fmt('{a}', { a = i(1, 'Why is this not for support') }),
          t('Not for support to do.')
        }),
        actions = c(8, {
          fmt('{a}', { a = i(1, 'What actions do PS need to take?') }),
          t('A quote to be provided to the customer')
        })
      }
    ))
}
