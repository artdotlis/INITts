TSV=5.0
NODE=18
NVMV=0.39.3
PCO=src/initts/ts/configs/project.js
NVM_DIR=$(HOME)/.nvm
NVM=[ -s $(NVM_DIR)/nvm.sh ] && \. $(NVM_DIR)/nvm.sh && nvm
NPM=[ -s $(NVM_DIR)/nvm.sh ] && \. $(NVM_DIR)/nvm.sh && npm

dev: setup	
	sed -i -E 's/(\"production\"\s*:)\s*[falstrue]+,/\1 false,/g' $(PCO)
	$(NPM) install 
	$(NPM) run hook	

devC: dev
	bash bin/deploy/post.sh

tests: setup
	sed -i -E 's/(\"production\"\s*:)\s*[falstrue]+,/\1 false,/g' $(PCO)
	$(NPM) install --omit optional

build: setup
	NODE_ENV=production $(NPM) install --omit dev --omit optional

docs: setup
	$(NPM) install --omit dev

setup:
	sed -i -E 's/(\"production\"\s*:)\s*[falstrue]+,/\1 true,/g' $(PCO)
	curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v$(NVMV)/install.sh" | bash
	$(NVM) install 18 
	$(NVM) use $(NODE)
	rm -rf node_modules
	git lfs install

uninstall:
	rm -rf $(NVM_DIR)

runAct: 
	$(NPM) -v
	bash

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
	NODE_ENV=production $(NPM) run build

runUpdate:
	$(NPM) update

commit: 
	$(NPM) run cz