#!/bin/bash

# COLORS
GREEN='\033[0;32m'
BLUE='\033[0;34m'
LIGHT_BLUE='\033[0;94m'
MAGENTA='\033[0;35m'
NC='\033[0m'

# PATHS
CCU_PATH=/var/www/prevac-cc-updater
MQI_PATH=/var/www/prevac-morpho-query-interface
VM_FILES_PATH=$CCU_PATH/vm
SITES_ENABLED_PATH=/etc/apache2/sites-enabled/

echo -e "${GREEN}\
################
## CC UPDATER ##
################
${NC}"
cd $CCU_PATH

echo -e "${BLUE}\
  Téléchargement des mises à jour
  ===============================
${NC}"
git pull

echo -e "${BLUE}
  Installation des mises à jour
  =============================
${NC}"
bundle install --deployment --without development test

echo -e "${BLUE}
  Mise à jour de la base de données
  =================================
${NC}"
bundle exec rake assets:precompile db:migrate RAILS_ENV=production

echo -e "${GREEN}\
#########
## MQI ##
#########
${NC}"
cd $MQI_PATH

echo -e "${BLUE}\
  Téléchargement des mises à jour
  ===============================
${NC}"
git pull

echo -e "${BLUE}
  Installation des mises à jour
  =============================
${NC}"
bundle install --deployment --without development test


echo -e "${GREEN}\
#######################
## MACHINE VIRTUELLE ##
#######################
${NC}"

echo -e "${BLUE}\
  Copie des fichiers
  ==================${NC}${LIGHT_BLUE}

  Saisir le mot de passe si nécessaire
  ------------------------------------
${NC}"
printf "${MAGENTA}\
    * cc-updater-updater.desktop
${NC}"
cp $VM_FILES_PATH/cc-updater-updater.desktop /home/$USER/.local/share/applications/

printf "${MAGENTA}\
    * icon.png
${NC}"
cp $VM_FILES_PATH/icon.png /home/$USER/Documents/update_apps/

printf "${MAGENTA}\
    * update_apps.sh
${NC}"
cp $VM_FILES_PATH/update_apps.sh /home/$USER/Documents/update_apps/

printf "${MAGENTA}\
    * cc-updater.conf
${NC}"
sudo cp $VM_FILES_PATH/cc-updater.conf $SITES_ENABLED_PATH

echo -e "${MAGENTA}\
    * mqi.conf
${NC}"
sudo cp $VM_FILES_PATH/mqi.conf $SITES_ENABLED_PATH


echo -e ${GREEN}"\
#################
## REDEMARRAGE ##
#################${NC}${BLUE}

              ------
  Appuyez sur ENTREE pour redémarrer
  =========== ------ ===============
${NC}"
read c
sudo reboot
