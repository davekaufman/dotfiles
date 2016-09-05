#!/bin/bash
# check_attachment.sh
## Source: http://wiki.mutt.org/?ConfigTricks/CheckAttach
##
## Edit muttrc to have this line:
## set sendmail = "/usr/local/bin/mutt_check_attachment_before_send.sh /usr/lib/sendmail -oem -oi"

## Attachment keywords that the message body will be searched for:
KEYWORDS='attachment|bijgevoegd|attached|bijgevoegd|bijvoeg|patch'

## Check that sendmail or other program is supplied as first argument.
if [ ! -x "$1" ]; then
    echo "Usage: $0 </path/to/mailprog> <args> ..."
    echo "e.g.: $0 /usr/sbin/sendmail -oem -oi"
    exit 2
fi

## Save msg in file to re-use it for multiple tests.
TMPFILE=`mktemp -t mutt_checkattach.XXXXXX` || exit 2
cat > "$TMPFILE"

## Define test for multipart message.
function multipart {
    grep -q '^Content-Type: multipart' "$TMPFILE"
}

## Define test for keyword search.
function word-attach {
    grep -v '^>' "$TMPFILE" | grep -E -i -q "$KEYWORDS"
}

## Header override.
function header-override {
    grep -i -E "^X-Attachment: *none *$" "$TMPFILE"
}

## FINAL DECISION:
if multipart || ! word-attach || header-override; then
    "$@" < "$TMPFILE"
    EXIT_STATUS=$?
else
    echo "No file was attached but a search of the message text suggests there should be one.  Add a header \"X-Attachment: none\" to override this check if no attachment is intended."
    EXIT_STATUS=1
fi

## Delete the temporary file.
rm -f "$TMPFILE"

## That's all folks.
exit $EXIT_STATUS
