set -x

function step() {
    echo -e "\e[1;32m$1\e[m"        # Green
}



# Unoffensive changes
step "sshd"
sed -i 's/^#\(PasswordAuthentication\) yes/\1 no/' /etc/ssh/sshd_config
systemctl enable sshd.service

step "mDNS"
sed -i 's/^\(hosts: .*\)\(resolve .*\)$/\1mdns_minimal [NOTFOUND=return] \2/' /etc/nsswitch.conf
systemctl enable avahi-daemon.service

step "pacman"
sed -i 's/^#\(Color\)/\1/' /etc/pacman.conf
sed -i 's/^#\(TotalDownload\)/\1/' /etc/pacman.conf
sed -i 's/^#\(VerbosePkgLists\)/\1/' /etc/pacman.conf

step "UFW"
ufw default deny
ufw limit SSH
ufw allow Bonjour
ufw enable
systemctl enable ufw.service



# Customizations
step "Archer"
git clone https://github.com/zwolbers/archer.git /root/archer

step "Dotfiles"
git clone https://github.com/zwolbers/dotfiles.git /root/.dotfiles
rm -f /root/.bashrc /root/.bash_profile
stow --no-folding --dir=/root/.dotfiles home    # Call stow directly - the repo's makefile doesn't play nicely with archiso

step "ssh"
cp /root/.ssh/id_ed25519.pub /root/.ssh/authorized_keys

step "Default Shell"
usermod -s /usr/bin/bash root

step "Remap Caps Lock"
gzip -cd /usr/share/kbd/keymaps/i386/qwerty/us.map.gz \
    | sed 's/^\(keycode  58 = \)Caps_Lock/\1Escape/' \
    | gzip > /usr/share/kbd/keymaps/i386/qwerty/us-caps-lock.map.gz
echo "KEYMAP=us-caps-lock" > /etc/vconsole.conf

step "Timezone"
ln -sf /usr/share/zoneinfo/America/Detroit /etc/localtime

step "Neovim"
curl -sSfLo /root/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall

step "tmux"
git clone https://github.com/tmux-plugins/tpm /root/.tmux/plugins/tpm
HOME=/root /root/.tmux/plugins/tpm/bin/install_plugins



step "Done"

