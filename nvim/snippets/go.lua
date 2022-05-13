return {
  s("f", fmt([[
  func main() {{
    {}
  }}
  ]], { i(0) })),
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
  s("fr", fmt([[
  func ({1}) {2}({3}) {4} {{
    {}
  }}
  ]], { i(1), i(2), i(3), i(4), i(0) })),
  s("fs", fmt([[
  func {1}({2}) {3} {{
    {}
  }}
  ]], { i(1), i(2), i(3), i(0) })),
  s("forr", fmt([[
  for _, {1} := range {2} {{
    {}
  }}
  ]], { i(1), i(2), i(0) })),
  s("er", fmt([[
  if err != nil {{
    {}
  }}
  ]], { i(0) })),
}

