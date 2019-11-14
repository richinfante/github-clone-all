# github-clone-all

This bash script clones all the git repos listed in your github account.

## Directory Structure

We clone each repo into a subdirectory named after the account / organization that owns the repo. If the directory doesn't exist, it'll be created.

For example, the repo: [https://github.com/microsoft/vscode.git](https://github.com/microsoft/vscode.git) will be cloned into a directory named `microsoft/vscode`

## Environment Variables

If you don't define these variables (nice for automation on a cron job), you'll be prompted for them.

- `GITHUB_USER` - your github username
- `GITHUB_TOKEN` - your github password, or token if you have 2fa enabled.

## Dependencies

- `jq` - for json processing
- `curl` - for web

