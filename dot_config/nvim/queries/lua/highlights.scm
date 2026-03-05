; Highlights global vim variable as a builtin, so that it gets the same color as other builtins like "math" and "string" in Lua.
; extends
((identifier) @variable.builtin
  (#eq? @variable.builtin "vim")
  (#set! "priority" 128))
