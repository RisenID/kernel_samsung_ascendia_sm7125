#!/bin/bash

sed -i -e 's/3\.1\.2/3\.2/g' a52q.sh a72q.sh ship.sh arch/arm64/configs/vendor/a52q_eur_open_defconfig arch/arm64/configs/vendor/a72q_eur_open_defconfig
sed "4 c\sed -i -e 's\/3.1.2\/3.2\/g' META-INF\/com\/google\/android\/update-binary" ship.sh > ship
rm -f ship.sh
mv ship ship.sh
chmod +x ship.sh
