TSV=5.0
NODE=18
NVMV=0.39.3
NVM_DIR=$(HOME)/.nvm
NVM=[ -s $(NVM_DIR)/nvm.sh ] && \. $(NVM_DIR)/nvm.sh && nvm
NPM=[ -s $(NVM_DIR)/nvm.sh ] && \. $(NVM_DIR)/nvm.sh && npm


dev: setup 
	$(NPM) install 
	$(NPM) run hook

devC: dev
	bash bin/deploy/post.sh

build: setup
	$(NPM) install --omit dev --omit optional

docs: setup
	$(NPM) install --omit dev

setup:
	curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v$(NVMV)/install.sh" | bash
	$(NVM) install 18 
	$(NVM) use $(NODE)

uninstall: exportNVM
	rm -rf $(NVM_DIR)

runCheck:
	$(NPM) run lint:eslint
	$(NPM) run lint:prettier

runDocs:
	echo "TODO"

runTests:
	echo "TODO"

runBuild:
	$(NPM) run build

runUpdate:
	$(NPM) update