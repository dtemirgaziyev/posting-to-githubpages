#!/bin/bash

sitedir="/home/$(whoami)/blog"
commitmsg="Updating website. $(date +%F)"

echo "Change directory to $sitedir..."
cd "$sitedir"
echo "Remove content from $sitedir/public & generate new content."
rm -rf "$sitedir"/public/*
hugo --quiet

echo "Change directory to $sitedir/public..."
cd "$sitedir"/public
if [[ -n $(git status -s) ]]
	then
	echo "Add changes to git."
	git add .
else
	echo "No changes to updating website."
	exit 1
fi

echo "Commit and push to remote repository."
git commit -m "$commitmsg"
git push origin master && echo "Done." || echo "ERROR!"