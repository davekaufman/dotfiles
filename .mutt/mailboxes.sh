#!/bin/bash
# $Id: mailboxes.sh 342078e6fbd5 2014/10/31 22:58:34 dave $
# adjust mailbox locations to automatically pull via IMAP when not logged into NOT_IMAP_HOST
# change hostnames as appropriate
case $(hostname -s) in
	NOT_IMAP_HOST)
		cat <<EOFLOCAL
			########## Mailboxes ##########
			#
			# fixes problem with fake new mail when filesystem mounted noatime
			# this option must occur before mailboxes are defined in the config
			# don't need this anymore, if we're using Maildir
			#set check_mbox_size
			# set mbox_type to maildir
			set mbox_type=Maildir
			## set spoolfile
			set spoolfile="~/mail/"

			set message_cachedir=~/.mutt/.cache/
			set header_cache=~/.mutt/.cache/
			# keep our cache clean
			set message_cache_clean = yes

			# set folder
			set folder="~/mail/"
			# set drafts (postponed) folder
			set postponed="~/mail/Drafts/"

			# make doubly sure we save our sent email
			set copy=yes
			set record="=sent"
			
			# set certificate file
			#set certificate_file=~/.mutt_certs
			
			# set up server-side mailboxes to check
			mailboxes =inbox
			mailboxes =spam
			mailboxes =cron
			
			# Set Default mailbox for old mail
			set mbox="~/mail/archive/inbox"
			# don't ask for permission to move read email to default mbox
			set move=no
			#
			########## End Mailboxes ##########
EOFLOCAL
	;;
	*)
		cat <<EOFLOCAL
			set spoolfile=imaps://$USER@example.com/INBOX
			set folder=imaps://$USER@example.com
			set postponed=imaps://$USER@example.com/Drafts
			# set certificate file
			set certificate_file=~/.mutt/.mutt_certs
			# directory to cache message information in
			set message_cachedir=~/.mutt/.cache/
			set header_cache=~/.mutt/.cache/
			# keep our cache clean
			set message_cache_clean = yes
			# set up server-side mailboxes to check
			mailboxes =inbox
			mailboxes =spam
			mailboxes =cron
			set mbox=imaps://$USER@example.com/INBOX
			# don't ask for permission to move read email to default mbox
			set move=no
EOFLOCAL
		;;
esac
