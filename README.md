# Archway

Small project to generate a custom [Arch Linux](https://www.archlinux.org/)
live image using [Archiso](https://wiki.archlinux.org/index.php/Archiso).
Largely intended as a starting point for [Archer]().

```console
# pacman -S archiso
# make
# dd bs=4M if=bin/archlinux-archway-x86_64.iso of=/dev/sdx status=progress oflag=sync
```

## Differences with the Official Image

Notable changes include:

* **tmux installed by default**
* **sshd enabled by default** - Password authentication is disabled.
* **Local hostname resolution (mDNS)** - Useful when setting up VMs, since
  host-only networks lack a DNS server.
    ```console
    $ ssh root@archiso.local
    ```

Several other changes were made for my convenience.  If you fork the
project, you'll probably want to update the following:

* My [dotfiles](https://github.com/zwolbers/dotfiles) are installed
* **My SSH key is authorized**
* Default shell set to Bash
* Caps Lock remapped to Escape
* Timezone set to America/Detroit

Read through `/src/` for a full list of changes.

