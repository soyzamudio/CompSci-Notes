var exec = require('child_process').exec;

transifex = (push, pull) ->
  push(pull)

# Push new source to Transifex
transifexPush = (pull) ->
  exec 'tx push -s', (err, stdout, stderr) ->
    console.log stdout
    if !err then pull()

# Pull translations from Transifex
transifexPull = ->
  exec 'tx pull -a -s -f', (err, stdout, stderr) ->
    console.log stdout
    if !err
      console.log 'Finish with Transifex'
      console.log 'Begin Github push'
      githubCommit()


# Create commit with updated translations for Github
githubCommit = ->
  exec 'git add . && git commit -m "Update translations"', (err, stdout, stderr) ->
    if !err then push()

# Push commit to branch _translations
githubPush = ->
  exec 'git push origin _translations',  (err, stdout, stderr) ->
    if !err then console.log 'Finished pushing translations to Github'

transifex(txpush, txpull);
