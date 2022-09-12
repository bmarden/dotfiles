setopt interactive_comments 
setopt hist_ignore_dups  
setopt octal_zeroes   
setopt no_prompt_cr  
setopt notify
setopt no_hist_no_functions 
setopt no_always_to_end  
setopt append_history 
setopt list_packed
setopt inc_append_history   
setopt complete_in_word  
setopt no_auto_menu   
setopt auto_pushd
setopt pushd_ignore_dups    
setopt no_glob_complete  
setopt no_glob_dots   
setopt c_bases
setopt numeric_glob_sort    
setopt share_history  
setopt promptsubst    
setopt auto_cd
setopt extended_history
setopt rc_quotes

# Remove delay when entering normal mode (vi)
KEYTIMEOUT=5

autoload -Uz allopt zed zmv zcalc colors