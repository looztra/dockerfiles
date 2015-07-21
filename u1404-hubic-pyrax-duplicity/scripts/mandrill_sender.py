import mandrill
import argparse
import sys
import os
import os.path

parser = argparse.ArgumentParser()
parser.add_argument("--content", help="the filename that contains the email body")
parser.add_argument("--to", help="the email recipient")
parser.add_argument("--subject", help="the subject")

args = parser.parse_args()

if not args.content:
    print "no email body file specified"
    sys.exit()

if not args.to:
    print "no target email address"
    sys.exit()

if not args.subject:
    print "no email subject specified"
    sys.exit()

if not os.path.isfile(args.content):
    print "the provided body file is not a file"
    sys.exit()

if not "MANDRILL_API_KEY" in os.environ:
    print "the env var 'MANDRILL_API_KEY' is not set"
    sys.exit()

with open (args.content, "r") as myfile:
    data=myfile.read()

try:
    mandrill_client = mandrill.Mandrill(os.environ['MANDRILL_API_KEY'])
    message = {
     'auto_html': None,
     'auto_text': None,     
     'from_email': 'christophe.furmaniak@gmail.com',
     'from_name': 'Webmaster Devlab722',               
     'important': False,
     'subject': args.subject,
     'text': data,
     'to': [{'email': args.to,
             'name': 'Recipient Name',
             'type': 'to'}],
     'track_clicks': None,
     'track_opens': None,
     'tracking_domain': None,
     'url_strip_qs': None,
     'view_content_link': None}
    result = mandrill_client.messages.send(message=message, async=False )

except mandrill.Error, e:
    # Mandrill errors are thrown as exceptions
    print 'A mandrill error occurred: %s - %s' % (e.__class__, e)
    # A mandrill error occurred: <class 'mandrill.UnknownSubaccountError'> - No subaccount exists with the id 'customer-123'    
    raise


