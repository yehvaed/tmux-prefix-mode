#!/usr/bin/env bash

export CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

initial_prefix=$(tmux show -gv prefix)
key=$(tmux show -gv "@TMUX_PREFIX_MODE_BINDING")
tmux bind-key -T root "${key}" set -g prefix None "\;" set key-table prefix "\;" refresh-client -S
tmux bind-key -T prefix "Escape" set -g prefix ${initial_prefix} "\;" set key-table root "\;" refresh-client -S

for key in {a..z} {A..Z}; do
    if [[ -z "$(tmux list-keys -T prefix ${key} 2> /dev/null)" ]]; then
        tmux bind-key -T prefix ${key} switch-client -T prefix
    fi
done
