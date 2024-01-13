# Colors
YELLOW := \033[1;33m
GREEN := \033[1;32m
RED := \033[1;31m
CYAN := \033[1;36m
ORANGE := \033[0;33m
PURPLE := \033[1;35m
WHITE := \033[1;37m
NC := \033[0m

# Conda commands
CONDA_ACTIVATE_BASE:=source ${CONDA_ROOT}/etc/profile.d/conda.sh; conda activate;

help:
	@echo -e " ${PURPLE}                                  LIST OF AVAILABLE COMMANDS                                    ${NC}"
	@echo -e " ${RED}======================|=========================================================================${NC}"
	@echo -e " ${RED}Command               | Description                                                             ${NC}"
	@echo -e " ${RED}======================|=========================================================================${NC}"
	@echo -e " ${YELLOW}SETUP ------------------------------------------------------------------------------------------${NC}"
	@echo -e " ${WHITE}  help                :${NC} prints this help message"
	@echo -e " ${WHITE}  jekyll-new          :${NC} create a new Jekyll project folder (use only in empty projects)"
	@echo -e " ${YELLOW}JEKYLL -----------------------------------------------------------------------------------------${NC}"
	@echo -e " ${WHITE}  jekyll-serve        :${NC} run the website locally"
	@echo -e " ${YELLOW}CLEAN ------------------------------------------------------------------------------------------${NC}"
	@echo -e " ${WHITE}  clean-folders       :${NC} cleans all folders and caches"
	@echo -e " ${WHITE}  clean               :${NC} runs all clean rules"
	@echo -e " ${YELLOW}MISC -------------------------------------------------------------------------------------------${NC}"
	@echo -e " ${WHITE}  pre-commit-run      :${NC} runs pre-commit hooks"
	@echo -e " ${WHITE}  commitizen-bump     :${NC} runs commitizen for releasing a new version on master branch"
	@echo -e " ${WHITE}  commitizen-push     :${NC} use git to push commits on 'development' and 'master' branches"
	@echo -e "${RED}=======================|=========================================================================${NC}"
	@echo ""

default: help

# Utilities -------------------------------------------------------------------
#Intentionally left void

# Setup rules -----------------------------------------------------------------

jekyll-new:
	@echo -e "${YELLOW}creating new project${NC}"
	jekyll new docs
	@echo -e "${GREEN}done${NC}"

# Jekyll rules ----------------------------------------------------------------

jekyll-serve:
	@echo -e "${YELLOW}start jekyll server${NC}"
	BUNDLE_GEMFILE=docs/Gemfile bundle exec jekyll serve --source docs --destination docs/_site
	@echo -e "${GREEN}done${NC}"

# Clean rules -----------------------------------------------------------------

clean-folders:
	@echo -e "${YELLOW}clean folders${NC}"
	rm -rf docs/_site/ docs/.sass-cache/ docs/.jekyll-cache/ docs/.jekyll-metadata docs/.bundle/
	@echo -e "${GREEN}done${NC}"

clean: clean-folders

# Other rules -----------------------------------------------------------------

pre-commit-run:
	@echo -e "${YELLOW}run pre-commit hooks${NC}"
	@${CONDA_ACTIVATE_BASE} \
	conda activate ci-cd && \
	pre-commit run
	@echo -e "${GREEN}done${NC}"

commitizen-bump:
	@echo -e "${YELLOW}run commitizen bump${NC}"
	@${CONDA_ACTIVATE_BASE} \
	conda activate ci-cd && \
	git checkout development && \
	git pull --ff-only && \
	git checkout master && \
	git pull --ff-only && \
	git merge development --no-ff && \
	cz bump --no-verify && \
	git checkout development && \
	git merge master --no-ff
	@echo -e "${GREEN}done${NC}"

commitizen-push:
	@echo -e "${YELLOW}run commitizen push${NC}"
	@${CONDA_ACTIVATE_BASE} \
	conda activate ci-cd && \
	git checkout development && \
	git pull --ff-only && \
	git checkout master && \
	git pull --ff-only && \
	git push &&\
	git push --tags &&\
	git checkout development && \
	git push
	@echo -e "${GREEN}done${NC}"
