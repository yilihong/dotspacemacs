(setq which-key-separator " ") ;; setting which-key
(setq which-key-max-description-length 20)
(use-package spaceline-config
  :ensure spaceline
  :config
  (spaceline-spacemacs-theme)
  (spaceline-helm-mode)
  ;;(spaceline-toggle-buffer-encoding-abbrev-off)
)
;;(require 'spaceline-config) ;; setting spaceline
;;(spaceline-spacemacs-theme)
(setq linum-format "%2d ")
(setq inhibit-splash-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(add-hook 'org-mode-hook 'visual-line-mode)
(global-git-commit-mode t)
(global-company-mode)
(autopair-global-mode t)
(delete-selection-mode 1) ;; delete the selected region when entering text
(menu-bar-mode -1)
(tool-bar-mode -1)
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
;; add golden ratio mode
;;(require 'golden-ratio)
;;(golden-ratio-mode 1)
(global-hungry-delete-mode)
;;(setq-default left-fringe-width nil)
;; (setq-default indent-tabs-mode nil)
(eval-after-load "vc" '(setq vc-handled-backends nil))
(setq vc-follow-symlinks t)
(setq large-file-warning-threshold nil)
(setq split-width-threshold nil)
(put 'narrow-to-region 'disabled nil)
(add-hook 'web-mode-hook 'rainbow-mode)  ;; hook rainbow-mode to the html mode as default
(global-set-key "\C-cg" 'writegood-mode)
(setq-default git-enable-magit-svn-plugin t)
(global-auto-revert-mode t)
(setq read-file-name-completion-ignore-case t)

(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)

(add-to-list 'default-frame-alist '(height . 51))
(add-to-list 'default-frame-alist '(width . 116))
(setq-default line-spacing 0.1)
(setq-default line-height 1.1)
(setq-default left-fringe-width  12)
(setq-default right-fringe-width 12)
(spacemacs//set-monospaced-font   "PragmataPro" "Hiragino Sans GB" 18 14);; set Chinese font
(setq ns-use-srgb-colorspace nil) ;; turn off srgb color
;; (setq-default 'cursor-type 'hbar) ;; change cursor type

(use-package helm
  :ensure t
  :init
  (progn
    (require 'helm-config)
    ;; limit max number of matches displayed for speed
    (setq helm-candidate-number-limit 16)
    ;; ignore boring files like .o and .a
    (setq helm-ff-skip-boring-files t)
    ;; replace locate with spotlight on Mac
    (setq helm-locate-command "mdfind -name %s %s"))
  :bind (("C-x f" . helm-for-files)))

(setq scroll-step            1
      scroll-conservatively  10000)

(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed"
  (interactive)
  (if (y-or-n-p (format "Sure you want to exit Emacs, Kevin? "))
      (if (< emacs-major-version 24)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs))
    (message "Kevin has canceled exiting Emacs.")))
(when window-system
  (global-set-key (kbd "C-x C-c") 'ask-before-closing))

(global-set-key [f8] 'neotree-toggle)
(setq neo-smart-open t)
(setq neo-theme 'ascii)
(setq neo-create-file-auto-open t)

(global-set-key (kbd "M-p") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

(custom-set-variables
 '(markdown-command "~/anaconda/bin/pandoc"))
(add-hook 'markdown-mode-hook 'pandoc-mode)
(add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)

(global-set-key (kbd "C-c z") 'reveal-in-osx-finder)

;;set up fly-check to ignore the E501 error
(setq-default flycheck-flake8-maximum-line-length 160)

(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'parenthesis)
(set-face-background 'show-paren-match (face-background 'default))
(set-face-foreground 'show-paren-match "maroon")
(set-face-attribute 'show-paren-match nil
                    :weight 'ultra-bold
                    :underline nil
                    :overline nil)

(global-undo-tree-mode)
(global-set-key (kbd "M-/") 'undo-tree-visualize)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C->") 'mc/mark-all-like-this)

(global-set-key (kbd "M-9") 'kill-whole-line)

;;set up flycheck for proselint
(require 'flycheck)
(flycheck-define-checker proselint
  "A linter for prose."
  :command ("proselint" source-inplace)
  :error-patterns
  ((warning line-start (file-name) ":" line ":" column ": "
            (id (one-or-more (not (any " "))))
            (message (one-or-more not-newline)
                     (zero-or-more "\n" (any " ") (one-or-more not-newline)))
            line-end))
  :modes (text-mode markdown-mode gfm-mode org-mode))

(add-to-list 'flycheck-checkers 'proselint)
(add-hook 'markdown-mode-hook #'flycheck-mode)
(add-hook 'gfm-mode-hook #'flycheck-mode)
(add-hook 'text-mode-hook #'flycheck-mode)
(add-hook 'org-mode-hook #'flycheck-mode)

(setq user-full-name "Yili Hong"
      user-mail-address "yili.hong@outlook.com"
      calendar-location-name "Tempe, AZ")

(shackle-mode 1)
(setq shackle-rules '(("\\`\\*helm.*?\\*\\'" :regexp t :align t :ratio 0.4)))
(push '("*osx-dictionary*" :width 0.4 :position right) popwin:special-display-config)

(defadvice vc-mode-line (after strip-backend () activate)
  (when (stringp vc-mode)
    (let ((gitlogo (replace-regexp-in-string "^ Git." "  " vc-mode)))
      (setq vc-mode gitlogo))))

(use-package smart-comment
  :ensure t
  :bind ("s-/" . smart-comment))

(use-package avy
  :ensure t
  :bind
  ("M-s" . avy-goto-word-1))

(setq osx-dictionary-dictionary-choice (list "English" "English Thesaurus"))
(global-set-key (kbd "C-c d") 'osx-dictionary-search-pointer)
(global-set-key (kbd "C-c i") 'osx-dictionary-search-input)

(global-set-key (kbd "C-c Y") 'youdao-dictionary-search-at-point+)
(global-set-key (kbd "C-c y") 'youdao-dictionary-search)
(push '("*Youdao Dictionary*" :width 0.4 :position right) popwin:special-display-config)
(setq youdao-dictionary-search-history-file "~/.emacs.d/.youdao")
(setq youdao-dictionary-use-chinese-word-segmentation t)

(when (require 'diminish nil 'noerror)
  (require 'diminish)
  ;; Hide jiggle-mode lighter from mode line
  (diminish 'jiggle-mode)
  ;; Replace abbrev-mode lighter with "Abv"
  (diminish 'abbrev-mode "Abv")
  (diminish 'projectile-mode "p")
  (diminish 'holy-mode)
  (diminish 'company-mode "c")
  ;;(diminish 'autopair-mode "")
  (diminish 'autopair-mode "ap")
  (diminish 'which-key-mode "wk")
  ;;(diminish 'which-key-mode "")
  (diminish 'reftex-mode "ref")
  ;;(diminish 'reftex-mode "")
  (diminish 'visual-line-mode "")
  (diminish 'hungry-delete-mode)
  (diminish 'golden-ratio-mode)
  (diminish 'evil-org-mode "eOrg")
  (diminish 'anzu-mode "")
  (diminish 'isearch-mode)
  (diminish 'magic-latex-buffer "")
  (diminish 'iimage-mode "")
  ;;(diminish 'flycheck-mode "")
  ;;(diminish 'python-mode "\f156")
  (eval-after-load "yasnippet"
    ;;'(diminish 'yas-minor-mode "")
    '(diminish 'yas-minor-mode "y")))

(global-anzu-mode +1)
(setq anzu-cons-mode-line-p nil) ;; avoid anzu info showing twice on spaceline
(set-face-attribute 'anzu-mode-line nil
                    :foreground "maroon" :weight 'bold)

(custom-set-variables
 '(anzu-mode-lighter "")
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 1000)
 '(anzu-replace-threshold 50)
 '(anzu-replace-to-string-separator " => "))

(global-set-key [remap query-replace] 'anzu-query-replace)
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)

;;(setq w3m-user-agent "Mozilla/5.0 (Linux; U; Android 2.3.3; zh-tw; HTC_Pyramid Build/GRI40) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.")
 ;; awesome wikipedia search
 (defun wikipedia-search (search-term)
   "Search for SEARCH-TERM on wikipedia"
   (interactive
    (let ((term (if mark-active
                    (buffer-substring (region-beginning) (region-end))
                  (word-at-point))))
      (list
       (read-string
        (format "Wikipedia (%s):" term) nil nil term)))
    )
   (browse-url
    (concat
     "http://en.m.wikipedia.org/w/index.php?search="
     search-term
     ))
   )

 ;;when I want to enter the web address all by hand
 (defun open-a-website (site)
   "Opens site in new w3m session with 'http://' appended"
   (interactive
    (list (read-string "Enter website address: http://" nil nil "scholar.google.com/citations?user=VwQmUFQAAAAJ&hl=en" )))
   (browse-url
    (concat "http://" site)))

;; (defvar ao/v-dired-omit t
;;   "If dired-omit-mode enabled by default. Don't setq me.")

;; (defun ao/dired-omit-switch ()
;;   "This function is a small enhancement for `dired-omit-mode', which will
;;  \"remember\" omit state across Dired buffers."
;;   (interactive)
;;   (if (eq ao/v-dired-omit t)
;;       (setq ao/v-dired-omit nil)
;;     (setq ao/v-dired-omit t))
;;   (ao/dired-omit-caller)
;;   (when (equal major-mode 'dired-mode)
;;     (revert-buffer)))

;; (defun ao/dired-omit-caller ()
;;   (if ao/v-dired-omit
;;       (setq dired-omit-mode t)
;;     (setq dired-omit-mode nil)))

;; (defun ao/dired-back-to-top()
;;   "Move to the first file."
;;   (interactive)
;;   (beginning-of-buffer)
;;   (dired-next-line 2))

;; (defun ao/dired-jump-to-bottom()
;;   "Move to last file."
;;   (interactive)
;;   (end-of-buffer)
;;   (dired-next-line -1))

(use-package keyfreq
  :ensure t
  :config
  (setq keyfreq-excluded-commands
        '(self-insert-command
          org-self-insert-command
          delete-backward-char
          pdf-view-next-page-command
          yas-expand
          pdf-view-scroll-up-or-next-page
          org-delete-backward-char
          mouse-drag-region
          LaTeX-insert-left-brace
          mouse-drag-region
          newline
          abort-recursive-edit
          previous-line
          next-line))
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

(let ((my-path (expand-file-name "/usr/local/texlive/2015/bin/x86_64-darwin/")))
  (setenv "PATH" (concat my-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-path))

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(autoload 'reftex-mode     "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex  "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase mode" t)
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode
(setq reftex-enable-partial-scans t)
(setq reftex-save-parse-info t)
(setq reftex-use-multiple-selection-buffers t)
(setq reftex-plug-into-AUCTeX t)

(use-package auctex
  :ensure t
  :mode ("\\.tex\\'" . latex-mode)
  :commands (latex-mode LaTeX-mode plain-tex-mode)
  :init
  (progn
    ;;(add-hook 'LaTeX-mode-hook 'visual-line-mode)
    (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
    (setq TeX-auto-save t
          TeX-parse-self t
          reftex-plug-into-AUCTeX t
          TeX-PDF-mode t))
  (add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
  (setq TeX-source-correlate-method 'synctex)
  (setq TeX-source-correlate-mode t)
  (eval-after-load "tex"
    '(add-to-list 'TeX-command-list '("xelatexmk" "latexmk -synctex=1 -shell-escape -xelatex %s" TeX-run-TeX nil t :help "Process file with xelatexmk"))
    )
  (add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "xelatexmk"))))

(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
      '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b %n %o %b")))

(use-package company-math
  :ensure t)

(use-package company-auctex
  :ensure t
  :config (progn
            (defun company-auctex-labels (command &optional arg &rest ignored)
              "company-auctex-labels backend"
              (interactive (list 'interactive))
              (case command
                (interactive (company-begin-backend 'company-auctex-labels))
                (prefix (company-auctex-prefix "\\\\.*ref{\\([^}]*\\)\\="))
                (candidates (company-auctex-label-candidates arg))))

            (add-to-list 'company-backends
                         '(company-auctex-macros
                           company-auctex-environments
                           company-math-symbols-unicode))

            (add-to-list 'company-backends #'company-auctex-labels)
            (add-to-list 'company-backends #'company-auctex-bibs)
            (setq company-math-disallow-unicode-symbols-in-faces nil)))

(require 'helm-bibtex)
(setq bibtex-autokey-year-length 4
      bibtex-autokey-name-year-separator "-"
      bibtex-autokey-year-title-separator "-"
      bibtex-autokey-titleword-separator "-"
      bibtex-autokey-titlewords 2
      bibtex-autokey-titlewords-stretch 1
      bibtex-autokey-titleword-length 5)

(setq bibtex-completion-bibliography '("~/Google Drive/bibliography/references.bib" "~/Google Drive/bibliography/olm.bib" "~/Google Drive/bibliography/kevin.bib"))
(setq reftex-default-bibliography
      '("~/Google Drive/bibliography/references.bib"))

(setq reftex-bibpath-environment-variables
      '("~/Google Drive/bibliography/"))

(setq reftex-default-bibliography '("~/Google Drive/bibliography/references.bib"))
(setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))

(setq reftex-default-bibliography
      (quote
       ("user.bib" "local.bib" "main.bib")))

(setq gscholar-bibtex-default-source "Google Scholar")
(setq gscholar-bibtex-database-file "~/Google Drive/bibliography/references.bib")

(setq font-latex-match-reference-keywords
      '(("cite" "[{")
        ("cites" "[{}]")
        ("autocite" "[{")
        ("footcite" "[{")
        ("footcites" "[{")
        ("parencite" "[{")
        ("textcite" "[{")
        ("fullcite" "[{")
        ("citetitle" "[{")
        ("citetitles" "[{")
        ("headlessfullcite" "[{")))

(setq reftex-cite-prompt-optional-args t)
(setq reftex-cite-cleanup-optional-args t)

(with-eval-after-load 'helm-bibtex
  (setcdr (rassoc "https://scholar.google.co.uk/scholar?q=%s"
                  bibtex-completion-fallback-options)
          "http://scholar.google.com/scholar?q=%s"))

(require 'helm-bibtex)
(require 'bibtex-completion)
(with-eval-after-load 'helm-bibtex
  (setq bibtex-completion-additional-search-fields '(tags)))

(defun bibtex-completion-my-publications ()
  "Search BibTeX entries authored by “Yili Hong”."
  (interactive)
  (helm :sources '(helm-source-bibtex)
        :full-frame t
        :input "Yili Hong"
        :candidate-number-limit 500))

;; (global-set-key (kbd "C-x p") 'bibtex-completion-my-publications)
(global-set-key (kbd "C-x p") 'helm-bibtex)
(global-set-key (kbd "C-x +") 'org-ref-bibtex-new-entry/body)

;; set key for agenda
(global-set-key (kbd "C-c a") 'org-agenda)

;;file to save todo items
(setq org-agenda-files '("~/todo.org"))

;;set priority range from A to C with default A
(setq org-highest-priority ?A)
(setq org-lowest-priority ?C)
(setq org-default-priority ?A)

;;set colours for priorities
(setq org-priority-faces '((?A . (:foreground "#F0DFAF" :weight bold))
                           (?B . (:foreground "LightSteelBlue"))
                           (?C . (:foreground "OliveDrab"))))

;;capture todo items using C-c c t
(define-key global-map (kbd "C-c c") 'org-capture)
(setq org-capture-templates
      '(("t" "todo" entry (file+headline "~/todo.org" "Tasks")
         "* TODO [#A] %?\nDEADLINE: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")))

;;open agenda in current window
(setq org-agenda-window-setup (quote current-window))
;;warn me of any deadlines in next 7 days
(setq org-deadline-warning-days 7)
;;show me tasks scheduled or due in next fortnight
(setq org-agenda-span (quote fortnight))
;;don't show tasks as scheduled if they are already shown as a deadline
(setq org-agenda-skip-scheduled-if-deadline-is-shown t)
;;don't give awarning colour to tasks with impending deadlines
;;if they are scheduled to be done
(setq org-agenda-skip-deadline-prewarning-if-scheduled (quote pre-scheduled))
;;don't show tasks that are scheduled or have deadlines in the
;;normal todo list
(setq org-agenda-todo-ignore-deadlines (quote all))
(setq org-agenda-todo-ignore-scheduled (quote all))
;;sort tasks in order of when they are due and then by priority
(setq org-agenda-sorting-strategy
      (quote
       ((agenda deadline-up priority-down)
        (todo priority-down category-keep)
        (tags priority-down category-keep)
        (search category-keep))))

(add-hook 'org-mode-hook
          (lambda ()
            (org-bullets-mode t)))
(setq org-bullets-bullet-list '("" "" "" "" "✸"))
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-src-window-setup 'current-window)
;;(setq org-ellipsis "")
(setf org-todo-keyword-faces '(("PLANED" . (:foreground "white" :background "#FF8598" :bold t :weight bold))
                               ("TODO" . (:foreground "white" :background "#AEAEAE"  :bold t :weight bold))
                               ("STARTED" . (:foreground "white" :background "#01B0F0" :bold t :weight bold))
                               ("DONE" . (:foreground "black" :background "#AEEE00" :bold t :weight bold))))

(require 'org-ref)
(require 'org-ref-pdf)
(require 'org-ref-url-utils)
(require 'dash)
(require 'hydra)
(require 'key-chord)
(require 'parsebib)
(require 'async)
(require 's)
(require 'f)
(require 'helm-net)
(require 'helm-easymenu)

(add-to-list 'org-latex-default-packages-alist '("" "natbib" "") t)
(add-to-list 'org-latex-default-packages-alist
             '("linktocpage,pdfstartview=FitH,colorlinks,
linkcolor=blue,anchorcolor=blue,
citecolor=blue,filecolor=blue,menucolor=blue,urlcolor=blue"
               "hyperref" nil)
             t)

;; Make RefTeX work with Org-Mode
;; use 'C-c (' instead of 'C-c [' because the latter is already
;; defined in orgmode to the add-to-agenda command.
(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c (") 'reftex-citation))

(add-hook 'org-mode-hook 'org-mode-reftex-setup)

(setq org-latex-pdf-process
    '("pdflatex -interaction nonstopmode -output-directory %o %f"
      "bibtex %b"
      "pdflatex -interaction nonstopmode -output-directory %o %f"
      "pdflatex -interaction nonstopmode -output-directory %o %f"))

(setq org-publish-project-alist
      '(("org-notes"
         :base-directory "~/org/"
         :publishing-directory "~/public_html/"
         :publishing-function org-twbs-publish-to-html
         :with-sub-superscript nil
         )))

(defun my-org-publish-buffer ()
  (interactive)
  (save-buffer)
  (save-excursion (org-publish-current-file))
  (let* ((proj (org-publish-get-project-from-filename buffer-file-name))
         (proj-plist (cdr proj))
         (rel (file-relative-name buffer-file-name
                                  (plist-get proj-plist :base-directory)))
         (dest (plist-get proj-plist :publishing-directory)))
    (browse-url (concat "file://"
                        (file-name-as-directory (expand-file-name dest))
                        (file-name-sans-extension rel)
                        ".html"))))

(setq org-latex-default-packages-alist
                (-remove-item
                 '("" "hyperref" nil)
                 org-latex-default-packages-alist))
(setq initial-major-mode 'org-mode
              initial-scratch-message "# This buffer is for notes you don't want to save\n\n")

;; (use-package reftex
;;   :commands turn-on-reftex
;;   :init
;;   (setq reftex-cite-format
;;         '((?\C-m . "\\cite[]{%l}")
;;           (?t . "\\citet{%l}")
;;           (?p . "\\citep[]{%l}")
;;           (?a . "\\autocite{%l}")
;;           (?A . "\\textcite{%l}")
;;           (?P . "[@%l]")
;;           (?T . "@%l [p. ]")
;;           (?x . "[]{%l}")
;;           (?X . "{%l}")))
;;   (setq bibtex-autokey-titleword-length 0
;;         bibtex-autokey-titleword-separator ""
;;         bibtex-autokey-titlewords 0
;;         bibtex-autokey-year-length 4
;;         bibtex-autokey-year-title-separator "")
;;   (setq reftex-default-bibliography '("~/Google Drive/bibliography/references.bib"))
;;   (setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))
;;   (setq reftex-extra-bindings t)
;;   :config
;;   (add-hook 'LaTeX-mode-hook 'turn-on-reftex))

;;enable magic-latex-buffer
;; (require 'magic-latex-buffer)
;; (add-hook 'latex-mode-hook 'magic-latex-buffer)
;; (add-hook 'Latex-mode-hook 'magic-latex-buffer)

;;(setq spaceline-window-numbers-unicode t)
;;(setq spaceline-workspace-numbers-unicode t)

;; setting transparency
;;(global-set-key (kbd "C-M-)") 'transparency-increase)
;;(global-set-key (kbd "C-M-(") 'transparency-decrease)

;; RefTeX formats for biblatex (not natbib)
;; (setq reftex-cite-format
;;       '(
;;         (?\C-m . "\\cite[]{%l}")
;;         (?t . "\\textcite{%l}")
;;         (?a . "\\autocite[]{%l}")
;;         (?p . "\\parencite{%l}")
;;         (?f . "\\footcite[][]{%l}")
;;         (?F . "\\fullcite[]{%l}")
;;         (?x . "[]{%l}")
;;         (?X . "{%l}")
;;         ))

;;(setq bibtex-completion-pdf-open-function
;;      (lambda (fpath)
;;        (call-process "open" nil 0 nil "-a" "/Applications/Skim.app" fpath)))
