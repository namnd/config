return {
  s("imr", fmt("import React from 'react'", {})),
  s("imrc", fmt([[
    import React from 'react'

    const {} = (): JSX.Element => {{
      return (
        <>{}</>
      )
    }}

    export default {}
    ]], {
      f(function(_, snip)
        return snip.env.TM_FILENAME_BASE or {}
      end, {1}),
      i(0),
      rep(1),
    })
  ),
  s("cfa", fmt([[
    const {} = ({}) => {{
      {}
    }}
    ]], { i(1), i(2), i(0) })
  ),
  s("ue", fmt([[
    useEffect(() => {{
      {1}
    }}, [{2}])
    ]], { i(1), i(2) })),
  s("uc", fmt([[
    const {1} = useCallback(() => {{
      {2}
    }}, [{3}])
    ]], { i(1), i(2), i(3) })),
  s("um", fmt([[
    const {1} = useMemo(() => {{
      {2}
    }}, [{3}])
    ]], { i(1), i(2), i(3) })),
}
