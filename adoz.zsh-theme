#  Adoz theme for Zsh (oh-my-zsh)
#
#  by Daviosoo (https://github.com/daviosoo/adoz-zsh-theme.git)

ADOZ_SHOW_TIMESTAMP="${ADOZ_SHOW_TIMESTAMP:-false}";
ADOZ_SHOW_USER="${ADOZ_SHOW_USER:-true}";
ADOZ_SHOW_HOSTNAME="${ADOZ_SHOW_HOSTNAME:-true}";
ADOZ_SHOW_CURRENT_DIR="${ADOZ_SHOW_CURRENT_DIR:-true}";
ADOZ_SHOW_GIT="${ADOZ_SHOW_GIT:-true}";

ADOZ_TIMESTAMP_COLOUR="${ADOZ_TIMESTAMP_COLOUR:-white}";
ADOZ_USER_COLOUR="${ADOZ_USER_COLOUR:-magenta}";
ADOZ_ROOT_USER_COLOUR="${ADOZ_ROOT_USER_COLOUR:-magenta}";
ADOZ_HOSTNAME_COLOUR="${ADOZ_HOSTNAME_COLOUR:-blue}";
ADOZ_CURRENT_DIR_COLOUR="${ADOZ_CURRENT_DIR_COLOUR:-white}";
ADOZ_GIT_COLOUR="${ADOZ_GIT_COLOUR:-cyan}";

ADOZ_TIMESTAMP_FORMAT="${ADOZ_TIMESTAMP_FORMAT:-%H:%M:%S}"; # see man strftime

ADOZ_PROMPT="${ADOZ_PROMPT:-→}";

ADOZ_GIT_SYMBOL_UNTRACKED="${ADOZ_GIT_SYMBOL_UNTRACKED:-?}";
ADOZ_GIT_SYMBOL_ADDED="${ADOZ_GIT_SYMBOL_ADDED:-+}";
ADOZ_GIT_SYMBOL_MODIFIED="${ADOZ_GIT_SYMBOL_MODIFIED:-!}";
ADOZ_GIT_SYMBOL_RENAMED="${ADOZ_GIT_SYMBOL_RENAMED:-!}";
ADOZ_GIT_SYMBOL_DELETED="${ADOZ_GIT_SYMBOL_DELETED:-!}";
ADOZ_GIT_SYMBOL_STASHED="${ADOZ_GIT_SYMBOL_STASHED:-*}";
ADOZ_GIT_SYMBOL_UNMERGED="${ADOZ_GIT_SYMBOL_UNMERGED:-M}";
ADOZ_GIT_SYMBOL_AHEAD="${ADOZ_GIT_SYMBOL_AHEAD:-↑}";
ADOZ_GIT_SYMBOL_BEHIND="${ADOZ_GIT_SYMBOL_BEHIND:-↓}";
ADOZ_GIT_SYMBOL_DIVERGED="${ADOZ_GIT_SYMBOL_DIVERGED:-~}";

# --

ZSH_THEME_GIT_PROMPT_UNTRACKED="${ZSH_THEME_GIT_PROMPT_UNTRACKED:-${ADOZ_GIT_SYMBOL_UNTRACKED}}";
ZSH_THEME_GIT_PROMPT_ADDED="${ZSH_THEME_GIT_PROMPT_ADDED:-${ADOZ_GIT_SYMBOL_ADDED}}";
ZSH_THEME_GIT_PROMPT_MODIFIED="${ZSH_THEME_GIT_PROMPT_MODIFIED:-${ADOZ_GIT_SYMBOL_MODIFIED}}";
ZSH_THEME_GIT_PROMPT_RENAMED="${ZSH_THEME_GIT_PROMPT_RENAMED:-${ADOZ_GIT_SYMBOL_RENAMED}}";
ZSH_THEME_GIT_PROMPT_DELETED="${ZSH_THEME_GIT_PROMPT_DELETED:-${ADOZ_GIT_SYMBOL_DELETED}}";
ZSH_THEME_GIT_PROMPT_STASHED="${ZSH_THEME_GIT_PROMPT_STASHED:-${ADOZ_GIT_SYMBOL_STASHED}}";
ZSH_THEME_GIT_PROMPT_UNMERGED="${ZSH_THEME_GIT_PROMPT_UNMERGED:-${ADOZ_GIT_SYMBOL_UNMERGED}}";
ZSH_THEME_GIT_PROMPT_AHEAD="${ZSH_THEME_GIT_PROMPT_AHEAD:-${ADOZ_GIT_SYMBOL_AHEAD}}";
ZSH_THEME_GIT_PROMPT_BEHIND="${ZSH_THEME_GIT_PROMPT_BEHIND:-${ADOZ_GIT_SYMBOL_BEHIND}}";
ZSH_THEME_GIT_PROMPT_DIVERGED="${ZSH_THEME_GIT_PROMPT_DIVERGED:-${ADOZ_GIT_SYMBOL_DIVERGED}}";

adozNewline () {
    echo '';
}

adozSymbol () {
    echo -n "%{$fg_bold[magenta]%}▲";
    echo -n ' ';
}

adozDecorate () {
    if [[ $2 == 'reset' ]]; then
        echo -n "%{$reset_color%}";
    else
        echo -n "%{$fg[$2]%}";
    fi;
    echo -n ${1};
    echo -n "%{$reset_color%}";
}

adozDecorateExpanded () {
    if [[ $2 == 'reset' ]]; then
        echo -n "%{$reset_color%}";
    else
        echo -n "%{$FG[$2]%}";
    fi;
    echo -n ${1};
    echo -n "%{$reset_color%}";
}

adozUser () {
    if [[ $USER == 'root' ]]; then
        adozDecorate '%n' "${ADOZ_ROOT_USER_COLOUR}";
    else
        adozDecorate '%n' "${ADOZ_USER_COLOUR}";
    fi;
}

adozHostname () {
    echo -n '@';
    echo -n ' ';
    adozDecorate '%m' "${ADOZ_HOSTNAME_COLOUR}";
}

adozCurrentDir () {
    echo -n '|';
    echo -n ' ';
    adozDecorateExpanded '%1~' "147";
}

adozGitStatus () {
    ADOZ_GIT_CURRENT_BRANCH=`git_current_branch | xargs echo -n`;
    ADOZ_GIT_PROMPT_STATUS=`git_prompt_status | sed -E 's/!+/!/g' | xargs echo -n`;
    if [[ ! -z "${ADOZ_GIT_CURRENT_BRANCH}" ]]; then
        echo -n 'at';
        echo -n ' ';
        adozDecorate "${ADOZ_GIT_CURRENT_BRANCH}" "${ADOZ_GIT_COLOUR}" "${ADOZ_GIT_BOLD}";
        if [[ ! -z "${ADOZ_GIT_PROMPT_STATUS}" ]]; then
            adozDecorate "(${ADOZ_GIT_PROMPT_STATUS})" "${ADOZ_GIT_COLOUR}" "${ADOZ_GIT_BOLD}";
        fi;
    fi;
}

adozTimestamp () {
    adozDecorate "%D{${ADOZ_TIMESTAMP_FORMAT}} |" "${ADOZ_TIMESTAMP_COLOUR}";
}

adozPrompt () {
    echo -n "%(?.%{$reset_color%}.%{$fg[red]%})";
    echo -n "${ADOZ_PROMPT}";
    echo -n "%{$reset_color%}";
    echo -n ' ';
}


adozBuildTheme () {
    adozNewline;
    echo -n ' ';
    if [[ ${ADOZ_SHOW_TIMESTAMP} = true ]]; then
        adozTimestamp;
        echo -n ' ';
    fi;
    if [[ ${ADOZ_SHOW_USER} = true ]]; then
    adozSymbol;
        adozUser;
        echo -n ' ';
    fi;
    if [[ ${ADOZ_SHOW_HOSTNAME} = true ]]; then
        adozHostname;
        echo -n ' ';
    fi;
    if [[ ${ADOZ_SHOW_CURRENT_DIR} = true ]]; then
        adozCurrentDir;
        echo -n ' ';
    fi;
    if [[ ${ADOZ_SHOW_GIT} = true ]]; then
        adozGitStatus;
    fi;
    adozNewline;
    adozNewline;
    adozPrompt;
}

PROMPT='$(adozBuildTheme)'
