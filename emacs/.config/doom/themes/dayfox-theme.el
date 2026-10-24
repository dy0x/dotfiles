;;; dayfox-theme.el --- Dayfox palette for Doom -*- lexical-binding: t; -*-

;; Palette and syntax mapping adapted from EdenEast/nightfox.nvim (MIT):
;; https://github.com/EdenEast/nightfox.nvim/blob/main/lua/nightfox/palette/dayfox.lua
;; Copyright (c) 2021 EdenEast
;; Palette used under the MIT license; see dayfox-LICENSE.

(require 'doom-themes)

(def-doom-theme dayfox
  "A light Dayfox port using Doom's shared face definitions."
  :background-mode 'light
  ((bg         '("#f6f2ee"))
   (bg-alt     '("#e4dcd4"))
   (fg         '("#3d2b5a"))
   (fg-alt     '("#643f61"))
   (base0      '("#f6f2ee"))
   (base1      '("#e4dcd4"))
   (base2      '("#dbd1dd"))
   (base3      '("#d3c7bb"))
   (base4      '("#aab0ad"))
   (base5      '("#837a72"))
   (base6      '("#824d5b"))
   (base7      '("#643f61"))
   (base8      '("#302b5d"))
   (grey       base5)
   (red        '("#a5222f"))
   (orange     '("#955f61"))
   (green      '("#396847"))
   (teal       '("#287980"))
   (yellow     '("#ac5402"))
   (blue       '("#2848a9"))
   (dark-blue  '("#a4c1c2"))
   (magenta    '("#6e33ce"))
   (violet     '("#a440b5"))
   (cyan       teal)
   (dark-cyan  teal)
   (highlight blue)
   (vertical-bar base3)
   (selection dark-blue)
   (builtin red)
   (comments base5)
   (doc-comments base5)
   (constants orange)
   (functions blue)
   (keywords magenta)
   (methods blue)
   (operators fg-alt)
   (type yellow)
   (strings green)
   (variables '("#352c24"))
   (numbers orange)
   (region '("#e7d2be"))
   (error red)
   (warning yellow)
   (success green)
   (vc-modified yellow)
   (vc-added green)
   (vc-deleted red))
  ((mode-line :background bg-alt :foreground fg-alt)
   (mode-line-inactive :background bg :foreground comments)
   (hl-line :background base3)
   (line-number :foreground base6)
   (line-number-current-line :foreground blue)
   (vertico-current :background selection :foreground fg)
   (org-block :background bg-alt))
  ())

;;; dayfox-theme.el ends here
