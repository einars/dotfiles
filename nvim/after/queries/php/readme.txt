changes from the default:

highlights.scm:
- "$" removed from @operator group to stop dirtying the beginning of variables,

Allow to target specifically function declaration name. Without this one can't
make the function name in the definition stand out,

- method_declaration/name: @method -> @method_declaration_name
- function_definition/name: @function -> @function_definition_name
- class_declaration/name: @type -> @class_declaration_name

These have to be added to custom captures to make use of:

lua <<EOF
require'nvim-treesitter.highlight'.set_custom_captures {
  -- Type is contrasty enough, even if not that semantic
  ["function_definition_name"] = "Type",
  ["method_declaration_name"] = "Type",
  ["class_declaration_name"] = "Type",
}
EOF
