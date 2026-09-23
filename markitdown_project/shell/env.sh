# Source this file in interactive shells or at the start of a batch script.
export R2MD_PROJECT_DIR="${R2MD_PROJECT_DIR:-$HOME/markitdown_project}"
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) export PATH="$HOME/.local/bin:$PATH" ;;
esac
# Same executable through a convenient interactive alias.
alias r2md='"$HOME/.local/bin/r2md"'
