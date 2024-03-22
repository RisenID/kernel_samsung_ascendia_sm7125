#!/bin/bash

sed -i -e 's/3\.1\.1/3\.1\.2/g' a52q.sh a72q.sh arch/arm64/configs/vendor/a52q_eur_open_defconfig arch/arm64/configs/vendor/a72q_eur_open_defconfig
sed -i -e 's/3.1.1\/3.1.2/3.1.1\/3.1.2/g' ship.sh
