TSV=5.0
NODE=18
NVMV=0.39.3
PCO=configs/dev/project.json
NVM_DIR=$(HOME)/.nvm
NVM=[ -s $(NVM_DIR)/nvm.sh ] && \. $(NVM_DIR)/nvm.sh && nvm
NPM=[ -s $(NVM_DIR)/nvm.sh ] && \. $(NVM_DIR)/nvm.sh && npm


dev: setup
	rm -rf node_modules
	$(NPM) install 
	$(NPM) run hook

devC: dev
	sed -i -E 's/(\"production\"\s*:)\s*[falstrue]+,/\1 false,/g' $(PCO)
	bash bin/deploy/post.sh

tests: setup
	$(NPM) install --omit optional

build: setup
	$(NPM) install --omit dev --omit optional

docs: setup
	$(NPM) install --omit dev

setup:
	sed -i -E 's/(\"production\"\s*:)\s*[falstrue]+,/\1 true,/g' $(PCO)
	curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v$(NVMV)/install.sh" | bash
	$(NVM) install 18 
	$(NVM) use $(NODE)

uninstall:
	rm -rf $(NVM_DIR)

runAct: 
	$(NPM) -v

runCheck:
	$(NPM) run lint
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