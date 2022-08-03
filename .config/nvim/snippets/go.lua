return {
  s("f", fmt([[
  func main() {{
    {}
  }}
  ]], { i(0) })),
  s("fu", fmt([[
  func {1}({2}) {3} {{
    {}
  }}
  ]], { i(1), i(2), i(3), i(0) })),
  s("me", fmt([[
  func ({1}) {2}({3}) {4} {{
    {}
  }}
  ]], { i(1), i(2), i(3), i(4), i(0) })),
  s("typest", fmt([[
  type {1} struct {{
    {}
  }}
  ]], { i(1), i(0) })),
  s("typei", fmt([[
  type {1} interface {{
    {}
  }}
  ]], { i(1), i(0) })),
  s("forr", fmt([[
  for _, {1} := range {2} {{
    {}
  }}
  ]], { i(1), i(2), i(0) })),
  s("fori", fmt([[
  for i := 0; i < {1}; i++ {{
    {}
  }}
  ]], { i(1), i(0) })),

  s("er", fmt([[
  if err != nil {{
    {}
  }}
  ]], { i(0) })),
  s("if", fmt([[
  if {1} {{
    {}
  }}
  ]], { i(1), i(0) })),
}

