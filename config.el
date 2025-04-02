;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-henna)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


(custom-set-faces!
  '(cursor :background "#33e8d3"))
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;; Set up Phpactor as a refactoring tool in PHP mode
(after! php-mode
  (setq phpactor-executable (executable-find "phpactor"))
  (map! :localleader
        :map php-mode-map
        "rr" #'phpactor-refactor
        "rc" #'phpactor-context-menu))

;; ;; Configure LSP for PHP (using Intelephense)
(after! lsp-mode
  (setq lsp-intelephense-server-command '("intelephense" "--stdio"))
  (add-hook 'php-mode-hook #'lsp))  ; enable lsp-mode for PHP files


(map! :leader :nv "s e" nil)
;; :nv es para que funcione en los modos normal y visual
;; Si quieres ver como funciona map haz "K" mayuscula encima de map!
;; Si quieres añadir algún shortcut con el espacio no lo añadas como bink ej "SPC c" sino que pon :leader, para que puedas usarlo
;; sin que se active el espacio en el modo insert
;; acuerdate de que K te enseña la doc y J concatena las lineas esta guay
(map! :desc "Comment Line" :nv "C-c l" #'comment-line)
(map! :leader :desc "Iedit Mode" :nv "s e" #'iedit-mode)
(map! :localleader :desc "Evil-Mc Mode" :nv "c" #'evil-mc-mode)
;; shift + intro es <return>
(after! projectile (setq projectile-project-root-files-bottom-up (remove ".git"
          projectile-project-root-files-bottom-up)))

(doom/set-frame-opacity 92)

;; after! se usa con un paquete, a veces el paquete se llama *-mode a veces se llama * y ya
(add-hook 'js-mode-hook
          (lambda() (setq js-indent-level 4)))

(add-hook 'js2-mode-hook
          (lambda() (setq js2-basic-offset 4)))

(add-hook 'typescript-mode-hook
          (lambda() (setq typescript-indent-level 4)))

(add-hook 'web-mode-hook
          (lambda() (setq web-mode-markup-indent-offset 4)
                     (setq web-mode-css-indent-offset 4)
                     (setq web-mode-code-indent-offset 4)
                     (setq web-mode-sql-indent-offset 4)))

(map! :nvie "<dead-grave>" "`")
(map! :nvie "<dead-acute>" "´")

(setq evil-shift-width 4)

(drag-stuff-global-mode 1)
(drag-stuff-define-keys)
; Esto solo sirve si se ejecuta emacs cada vez (add-to-list 'default-frame-alist '(width . 160))  ; Width set to 80 characters (add-to-list 'default-frame-alist '(height . 45)) ; Height set to 24 lines
; Config para cliente de emacs, establece el tamaño del frame y la opacidad cada vez que se abre
; emacsclient -c -e "(progn (select-frame-set-input-focus (selected-frame)) (doom/set-frame-opacity 92) (set-frame-size (selected-frame) 150 41))"

; Hacer que esta configuración funcione me ha costado sangre sudor y lágrimas :) (solo 3 horitas jiji)
(setq lsp-clients-angular-language-server-command
  '("node" "/usr/lib/node_modules/@angular/language-server"
    "--ngProbeLocations" "/usr/lib/node_modules"
    "--tsProbeLocations" "/usr/lib/node_modules"
    "--stdio"))

; Requiere angular-ls, si no lo tienes instálalo con npm install -g @angular/language-service@next typescript  @angular/language-server
(after! lsp-mode
  (add-to-list 'lsp-language-id-configuration
               '(ng2-html-mode . "angular"))

  (add-to-list 'lsp-language-id-configuration
               '(ng2-ts-mode . "angular"))

  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection lsp-clients-angular-language-server-command)
    :major-modes '(ng2-html-mode ng2-ts-mode)
    :server-id 'angular-ls)))

;(setq lsp-log-io t) ; Activalo cada vez que quieras añadir un lsp personalizado
