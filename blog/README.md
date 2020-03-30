Kevin DeMarco's Blog
====================

While on the "blog" branch.

    $ cd blog

Dependencies
------------

    $ gem install bundler
    $ gem install jekyll

Development
-----------

    $ bundle exec jekyll serve

Deploy
------

    $ JEKYLL_ENV=production bundle exec jekyll build


The static pages need to be pushed to the "master" branch to be served by GitHub:

    $ cd ../
    $ git checkout master
    $ git pull origin master
    $ cp -r ./blog/_site/* .
    $ git commit -a -m "some message"
    $ git push origin master
