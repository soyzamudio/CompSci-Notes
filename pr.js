var exec = require('child_process').exec;

var GitHubApi = require('github');

var github = new GitHubApi({
  version: '3.0.0',
  debug: true
});


var createCommit = function() {
  return exec('git add . && git commit -m "Testing commit from node.js" && git push origin test-pr', function(err, stdout, stderr) {
    console.log(err);
    if (!err) {
      var msg = {
        user: 'theCodeBear',
        repo: 'CompSci-Notes',
        title: 'Testing PR Title',
        base: 'test-pr',
        head: 'test-pr'
      }
      github.pullRequests.create(msg, function(err, data) {
        console.log('\n\n***** err *****\n\n', err);
        console.log('\n\n***** data *****\n\n', data);
      });
    }
  });
}

createCommit()
