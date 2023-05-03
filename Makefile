TSV=5.0
NODE=18
NVM=0.39.3
NVM_DIR=$(HOME)/.nvm


dev: setup 
	npm install 
	npm run hook

devC: dev
	bash bin/deploy/post.sh

build: setup
	npm install --omit dev --omit optional

docs: setup
	npm install --omit dev

setup:
	curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v$(NVM)/install.sh" | bash
	[ -s "$(NVM_DIR)/nvm.sh" ] && \. "$(NVM_DIR)/nvm.sh" && nvm install 18 && nvm use $(NODE)

uninstall: exportNVM
	rm -rf $(NVM_DIR)

runCheck:
	npm run lint:eslint
	npm run lint:prettier

runDocs:
	echo "TODO"

runTests:
	echo "TODO"

runBuild:
	npm run build

runUpdate:
	npm update