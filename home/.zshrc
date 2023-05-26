# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#################################  HISTORY  #################################
# history
HISTFILE=$HOME/.zsh_history     # 履歴を保存するファイル
HISTSIZE=100000                 # メモリ上に保存する履歴のサイズ
SAVEHIST=1000000                # 上述のファイルに保存する履歴のサイズ

# share .zshhistory
setopt inc_append_history       # 実行時に履歴をファイルにに追加していく
setopt share_history            # 履歴を他のシェルとリアルタイム共有する

setopt hist_ignore_all_dups     # ヒストリーに重複を表示しない
setopt hist_save_no_dups        # 重複するコマンドが保存されるとき、古い方を削除する。
setopt extended_history         # コマンドのタイムスタンプをHISTFILEに記録する
setopt hist_expire_dups_first   # HISTFILEのサイズがHISTSIZEを超える場合は、最初に重複を削除します

autoload -Uz colors; colors

# Tabで選択できるように
zstyle ':completion:*:default' menu select=2

# 補完候補をそのまま→小文字を大文字→大文字を小文字に変更
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

### 補完方法毎にグループ化する。
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''

# ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# カッコを自動補完
setopt auto_param_keys

# ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt mark_dirs

# 補完キー連打で順に補完候補を自動で補完
setopt auto_menu

# スペルミス訂正
setopt correct

# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# 語の途中でもカーソル位置で補完
setopt complete_in_word

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# ディレクトリ名だけでcdする
setopt auto_cd

# ビープ音を消す
setopt no_beep

# コマンドを途中まで入力後、historyから絞り込み
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

#alias


if [[ $(command -v exa) ]]; then
  alias e='exa --icons --git -FG'
  alias l=e
  alias ls=e
  alias ea='exa -a --icons --git -FG'
  alias la=ea
  alias ee='exa -aahl --icons --git -FG'
  alias ll=ee
  alias et='exa -T -L 2 -a -I "node_modules|.git|.cache" --icons -FG'
  alias lt=et
  alias eta='exa -T -a -I "node_modules|.git|.cache" --color=always --icons -FG | less -r'
  alias lta=eta
  alias l='clear && ls'
fi

## SSH
alias sshk='ssh-keygen -t rsa'
alias vsc='vi ~/.ssh/config'

## Node
alias n='node index.js'

### npm
alias ni='npm install'
alias nu='npm uninstall'
alias nr='npm run'

### yarn
alias ya='yarn add'
alias yr='yarn remove'
alias yi='yarn install'

## git
alias gs='git status'
alias gaa='git add'
alias gc-b='git checkout -b'
alias gc-m='git commit -m'
alias gp='git push'

## zsh
alias sz='source ~/.zshrc'
alias vz='vi ~/.zshrc'

##Eigen##
export CPATH=/opt/homebrew/Cellar/eigen/3.4.0_1/include/eigen3/:$CPATH

##GitHub
eval "$(gh completion -s zsh)"

##Geant4
export PATH="/opt/homebrew/opt/qt@5/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/qt@5/lib -L/opt/homebrew/opt/qwt/lib $LDFLAGS"
export CPPFLAGS="-I/opt/homebrew/opt/qt@5/include -I/opt/homebrew/opt/qwt/include $CPPFLAGS"
export PKG_CONFIG_PATH="/opt/homebrew/opt/qt@5/lib/pkgconfig:$PKG_CONFIG_PATH"

cd /Users/knakano/PhysicsSoftware/geant4/bin
source geant4.sh
cd - > /dev/null
cd

##LLVM
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib $LDFLAGS"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include $CPPFLAGS"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

##ForLatex
export PATH=$PATH:/usr/local/texlive/2023/bin/universal-darwin:"/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
zinit light zsh-users/zsh-autosuggestions
#zinit light marlonrichert/zsh-autocomplete
zinit light mollifier/anyframe
zinit light zdharma/fast-syntax-highlighting

#For C++ PathSimulation
export PATH=/Users/knakano/git/muon_imaging_cpp_simulation:$PATH

