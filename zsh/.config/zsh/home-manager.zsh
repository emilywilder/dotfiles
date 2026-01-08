HM_SESSION_VARS_FILE=/etc/profiles/per-user/${USERNAME}/etc/profile.d/hm-session-vars.sh

if [ -f ${HM_SESSION_VARS_FILE} ]; then
    source ${HM_SESSION_VARS_FILE}
fi
