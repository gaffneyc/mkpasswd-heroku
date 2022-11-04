# mkpasswd-heroku
SHA-512 /etc/shadow hash generator

## Archived

With Heroku [removing free plans and dyno sleeping](https://blog.heroku.com/next-chapter) it's time to retire this little application. I originally created this because OS X didn't support generting SHA-512 hashes via crypt. Support was added several years ago and I'm no longer working with Chef (which was the reason we needed to generate the hashes).

:wave:
