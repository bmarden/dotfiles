; extends

; Carry markup.heading/strong/italic highlighting through a single wrapper
; component like lingui's <Trans>, which nests the jsx_text one level deeper so
; the upstream "direct jsx_text child" rules no longer match.
;
; Matches: <h1><Trans>text</Trans></h1>
;
; The inner (jsx_element) is anchored with a field name (so it only binds the
; wrapper element, not every descendant) to avoid a combinatorial match
; explosion on deeply-nested JSX (e.g. tables), which would otherwise make the
; treesitter highlighter drop captures and lose syntax color on those lines.

(jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  .
  (jsx_element
    (jsx_text) @markup.heading.1 @nospell)
  .
  (#eq? @_tag "h1"))

(jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  .
  (jsx_element
    (jsx_text) @markup.heading.2 @nospell)
  .
  (#eq? @_tag "h2"))

(jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  .
  (jsx_element
    (jsx_text) @markup.heading.3 @nospell)
  .
  (#eq? @_tag "h3"))

(jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  .
  (jsx_element
    (jsx_text) @markup.heading.4 @nospell)
  .
  (#eq? @_tag "h4"))

(jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  .
  (jsx_element
    (jsx_text) @markup.heading.5 @nospell)
  .
  (#eq? @_tag "h5"))

(jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  .
  (jsx_element
    (jsx_text) @markup.heading.6 @nospell)
  .
  (#eq? @_tag "h6"))

(jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  .
  (jsx_element
    (jsx_text) @markup.heading)
  .
  (#eq? @_tag "title"))

(jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  .
  (jsx_element
    (jsx_text) @markup.strong)
  .
  (#any-of? @_tag "strong" "b"))

(jsx_element
  (jsx_opening_element
    name: (identifier) @_tag)
  .
  (jsx_element
    (jsx_text) @markup.italic)
  .
  (#any-of? @_tag "i" "em"))
