Kevin DeMarco's Blog
====================

While on the "blog" branch.

    $ cd blog

Install Ruby / Dependencies
---------------------------

Install git-lfs, which is used for images and large binary files:

    $ sudo apt-get install git-lfs

Install the git-lfs hooks for this repo:

    $ cd /path/to/this/repo
    $ git lfs install

Pull down the git-lfs objects:

    $ git lfs pull

Install ruby:

    $ sudo apt install ruby-full

Setup path and gems location:

    $ echo 'export GEM_HOME="${HOME}/gems"' >> ~/.bashrc && \
      echo 'export PATH="${GEM_HOME}/bin:${PATH}"' >> ~/.bashrc

Install bundler and jekyll

    $ gem install bundler
    $ gem install jekyll

Development
-----------

Install packages for this blog

    $ bundle install

Start the web server to view the website

    $ bundle exec jekyll serve

Deploy
------

The static pages need to be pushed to the "master" branch to be served by
GitHub. I use a separate git worktree to make this process easier.

Setup the git worktree:

    $ cd /path/to/this/repo
    $ git checkout blog
    $ git worktree add ../static-blog master

Build the production code.

    $ cd /path/to/this/repo/blog
    $ JEKYLL_ENV=production bundle exec jekyll build

After building the production website, just copy the static pages to the
"static-blog" directory and push to the master branch.

    $ cd ../
    $ git checkout master
    $ git pull origin master
    $ cp -r ./blog/_site/* .
    $ git commit -a -m "some message"
    $ git push origin master
