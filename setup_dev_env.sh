RED='\033[1;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
CODE='\033[1;30;43m'
NC='\033[0m'

CONDA_PROJECT_ENV=fatto-a-mano

# Install conda environments
echo -e "${YELLOW}installing ruby environment${NC}"
conda env create -f requirements/environment.yml
echo -e "${YELLOW}activate with ${CODE} conda activate ${CONDA_PROJECT_ENV} ${NC}\n"

echo -e "${YELLOW}installing ci-cd environment${NC}"
conda env create -f requirements/ci-cd.yml
echo -e "${YELLOW}activate with ${CODE} conda activate ci-cd ${NC}\n"

echo -e "${GREEN}environments installed${NC}\n"

# Install pre-commit hooks
#echo -e "${YELLOW}installing pre-commit environment${NC}"
#conda activate pre-commit
#pre-commit install
#echo -e "\n${GREEN}pre-commit hooks installed${NC}\n"
#while true; do
#    echo -e "${YELLOW}autoupdate pre-commit hooks? [y/n]${NC}"
#    read yn
#    case $yn in
#        [Yy]*)  pre-commit autoupdate ; echo -e "\n${GREEN}pre-commit hooks updated${NC}\n" ; break ;;  
#        [Nn]*) echo "\n${RED}pre-commit hooks not updated${NC}\n" ; break ;;
#    esac
#done
#conda deactivate

# Activate dev env
echo -e "${YELLOW}activate development environment${NC}"
conda activate ${CONDA_PROJECT_ENV} ;
echo -e "\n${GREEN}environment activated${NC}\n" ;

echo -e "${YELLOW}install ruby gems${NC}"
gem install jekyll bundler
echo -e "\n${GREEN}gems installed${NC}\n" ;

echo -e "${YELLOW}fix ruby location with symlink${NC}"
ln -s "${CONDA_PREFIX}/bin/ruby" "${CONDA_PREFIX}/share/rubygems/bin/ruby"
echo -e "\n${GREEN}symlink created${NC}\n" ;

echo -e "${GREEN}done${NC}\n"

return 0