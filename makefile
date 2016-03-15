.PHONY: debugtest

install:
	@npm install --production

debugtest:
	./node_modules/.bin/mocha --debug-brk --compilers coffee:coffee-script/register test

deploy:
	heroku create
	heroku addons:create heroku-postgresql:hobby-dev
	heroku addons:create sendgrid:starter
	NOW=`date`
	SECRET=`echo -n $NOW | openssl dgst -sha256`
	heroku config:set SERVER_SECRET=$SECRET
