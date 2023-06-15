TSV=5.0
NODE=18
NVMV=0.39.3
PCO=src/initts/ts/configs/project.js
NVM_DIR=$(HOME)/.nvm
NVM=[ -s $(NVM_DIR)/nvm.sh ] && \. $(NVM_DIR)/nvm.sh && nvm
ifeq ($(shell grep "production:\s*true," $(PCO)),)
NODE_ENV=development
POST=bash bin/deploy/post.sh
else
NODE_ENV=production
POST=echo "no post in production"
endif
NPM=[ -s $(NVM_DIR)/nvm.sh ] && \. $(NVM_DIR)/nvm.sh && NODE_ENV=$(NODE_ENV) npm

dev: setup
	$(NPM) install 
	$(NPM) run hook	

tests: setup
	$(NPM) install --omit optional

build: setup 
	$(NPM) install --omit dev --omit optional

docs: setup
	$(NPM) install --omit dev

setup:
	curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v$(NVMV)/install.sh" | bash
	$(NVM) install 18 
	$(NVM) use $(NODE)
	rm -rf node_modules
	git lfs install
	$(POST)

uninstall:
	rm -rf $(NVM_DIR)

runAct: 
	$(NPM) -v
	bash

actDev:	
	sed -i -E 's/(production\s*:)\s*[falstrue]+,/\1 false,/g' $(PCO)

actProd:
	sed -i -E 's/(production\s*:)\s*[falstrue]+,/\1 true,/g' $(PCO)

runCheck: runBuild
	$(NPM) run lint
	$(NPM) run lint:prune
	$(NPM) run lint:eslint
	$(NPM) run lint:prettier
	$(NPM) run lint:shell

runDocs:
	echo "TODO"

runTests:
	echo "TODO"

runBuild:
	$(NPM) run build

runUpdate:
	$(NPM) update

commit: 
	$(NPM) run cz