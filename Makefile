push: build
	./push.sh $(arg1)

build: 
	JEKYLL_ENV=production bundle exec jekyll build
