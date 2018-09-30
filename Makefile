default: bin/archlinux-archway-x86_64.iso


bin/archlinux-archway-x86_64.iso: | bin/
bin/archlinux-archway-x86_64.iso: /usr/share/archiso/configs/releng
bin/archlinux-archway-x86_64.iso: src/packages src/customizations.sh
	rm -rf                                          bin/releng/
	cp -r /usr/share/archiso/configs/releng/        bin/
	cat src/packages                             >> bin/releng/packages.x86_64
	cat src/customizations.sh                    >> bin/releng/airootfs/root/customize_airootfs.sh
	cd bin/releng/ && ./build.sh -V archway -L `date +ARCHWAY_%F` -P "`hostname`" -A "Custom Arch Linux Live/Rescue CD" -o ..
	@echo
	@echo "Run the following to install:"
	@echo "# dd bs=4M if=bin/archlinux-archway-x86_64.iso of=/dev/sdx status=progress oflag=sync"
	@echo


clean:
	rm -rf bin/

%/:
	mkdir -p $@

