(list_lit
  value: (sym_lit) @keyword.deftrace
  value: (sym_lit) @def_function_name
  (#eq? @keyword.deftrace "deftrace"))

(list_lit
  value: (sym_lit) @keyword.def
  value: (sym_lit) @def_val_name
  (#eq? @keyword.def "def"))

(list_lit
  value: (sym_lit) @keyword.set
  value: (sym_lit) @def_val_name
  (#eq? @keyword.set "set!"))

(list_lit
  value: (sym_lit) @keyword.defn
  value: (sym_lit) @def_function_name
  (#eq? @keyword.defn "defn"))

