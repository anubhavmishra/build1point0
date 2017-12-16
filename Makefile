.DEFAULT_GOAL := help
help: ## List targets & descriptions
	@cat Makefile* | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

deps: ## Download dependencies
	go get github.com/apex/static/cmd/static-docs 

build: ## Generate HTML from markdown
	static-docs --in posts --out . --title build1point0 --subtitle "Its about time I had a blog...."