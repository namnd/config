return {
  s("imp", fmt([[import {{ {2} }} from '{1}']], { i(1), i(2) } )),
  s("exportas", fmt([[
  export const {1} = async ({2}) => {{
    {}
  }}
  ]], { i(1), i(2), i(0) })),
  s("fori", fmt([[
  for (let i = 0; i < {1}; i++) {{
    {}
  }}
  ]], { i(1), i(0) } )),
  s("tryc", fmt([[
  try {{
    {}
  }} catch (error) {{
    console.log(error)
  }}
  ]], { i(0) })),
}

