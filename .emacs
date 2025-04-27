;9u;; Followed by Tsodings "Configuring Emacs on My New Laptop"
(setq custom-file "~/.emacs.custom.el")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'use-package-ensure)

(require 'tree-sitter)
(require 'tree-sitter-langs)

(use-package quelpa
  :ensure t
  :custom
  (quelpa-checkout-melpa-p nil) ;; Dont auto-update melpa!
  (quelpa-upgrade-p nil))       ;; Dont auto-upgrade packages!
(use-package quelpa-use-package
  :demand
  :config
  (quelpa-use-package-activate-advice))

;; Install tree-sitter and tree-sitter-langs if not already installed
(unless (package-installed-p 'tree-sitter)
  (package-refresh-contents)
  (package-install 'tree-sitter))

(unless (package-installed-p 'tree-sitter-langs)
  (package-refresh-contents)
  (package-install 'tree-sitter-langs))

;; Install quelpa if not already installed
(unless (package-installed-p 'quelpa)
  (package-refresh-contents)
  (package-install 'quelpa))

;;(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font-12"))
(add-to-list 'default-frame-alist '(font . "Comic Mono-13"))

(tool-bar-mode 0)
(menu-bar-mode 0)
(fido-vertical-mode)

(scroll-bar-mode 0)
(global-display-line-numbers-mode)

(load-file custom-file)
(load-file "~/.emacs.local/simpc-mode.el")

(setq company-idle-delay 0.2)  ;; Delay before suggestions appear
(setq company-minimum-prefix-length 1)  ;; Minimum characters before suggestions

(xclip-mode 1)

;; Odin-mode
;;(load-file "~/.emacs.local/odin-mode.el")
(use-package odin-mode
  :quelpa (odin-mode :fetcher github :repo "mattt-b/odin-mode")
  :mode ("\\.odin\\'" . odin-mode))

;; Odin LSP
;; Pull the lsp-mode package
(use-package lsp-mode
  :commands (lsp lsp-deferred))

;; Set up OLS as the language server for Odin, ensuring lsp-mode is loaded first
(with-eval-after-load 'lsp-mode
  (setq-default lsp-auto-guess-root t) ;; Helps find the ols.json file with Projectile or project.el
  (add-to-list 'lsp-language-id-configuration '(odin-mode . "odin"))
  (add-to-list 'lsp-language-id-configuration '(odin-ts-mode . "odin"))

  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "~/repos/ols/ols") ;; Adjust the path here
                    :major-modes '(odin-mode odin-ts-mode)
                    :server-id 'ols
                    :multi-root t))) ;; Ensures lsp-mode sends "workspaceFolders" to the server

;; Add hooks
(add-hook 'odin-mode-hook #'lsp-deferred)

(add-hook 'after-init-hook 'global-company-mode)

(add-hook 'c-mode-hook #'tree-sitter-mode)
(add-hook 'c-mode-hook #'tree-sitter-hl-mode)

(add-hook 'c++-mode-hook #'tree-sitter-mode)
(add-hook 'c++-mode-hook #'tree-sitter-hl-mode)
