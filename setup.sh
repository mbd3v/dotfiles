#!/bin/bash
# Usage: ./setup.sh           symlink managed paths into $HOME
#        ./setup.sh --check   list managed paths that aren't symlinks into this repo
#        ./setup.sh --root    copy managed files into /root
set -euo pipefail

repo="$(cd "$(dirname "$0")" && pwd)"

# Each entry is a path that's the same in the repo and $HOME, or repo_path:home_path.
# .config/nvim is linked as a whole directory so files nvim creates land in the repo.
# claude/ isn't named .claude/ so Claude Code doesn't load it as project config inside this repo.
links=(.config/nvim .config/foot/foot.ini .zshrc .vimrc .tmux.conf .p10k.zsh
       claude/settings.json:.claude/settings.json
       claude/skills/code-style:.claude/skills/code-style
       claude/skills/unslop:.claude/skills/unslop)

case "${1:-}" in
    "")
        stamp=$(date +%Y%m%d-%H%M%S)
        for path in "${links[@]}"; do
            src="$repo/${path%%:*}"
            target="$HOME/${path#*:}"
            [ "$(readlink "$target")" = "$src" ] && continue
            mkdir -p "$(dirname "$target")"
            if [ -e "$target" ] || [ -L "$target" ]; then
                mv "$target" "$target.bak.$stamp"
                echo "backed up $target -> $target.bak.$stamp"
            fi
            ln -s "$src" "$target"
            echo "linked $target"
        done
        ;;
    --check)
        bad=0
        for path in "${links[@]}"; do
            if [ "$(readlink "$HOME/${path#*:}")" != "$repo/${path%%:*}" ]; then
                echo "not linked: $HOME/${path#*:}"
                bad=1
            fi
        done
        exit $bad
        ;;
    --root)
        # Copies, not links, so root's nvim never writes root-owned files into the repo.
        # install unlinks the destination first, which also drops old hard links into this repo.
        for path in "${links[@]}"; do
            src="${path%%:*}"
            dest="${path#*:}"
            (cd "$repo" && find "$src" -type f) | while read -r file; do
                mode=644
                [ -x "$repo/$file" ] && mode=755
                sudo install -D -m "$mode" "$repo/$file" "/root/$dest${file#"$src"}"
            done
        done
        echo "copied into /root"
        ;;
    *)
        echo "usage: $0 [--check|--root]" >&2
        exit 2
        ;;
esac
