#!/bin/bash

cd ../../builds/ascendia/sm7125/pack_ksu/
sed -i -e 's/3.1.2/3.2/g' META-INF/com/google/android/update-binary
zip -r Ascendia_3.2_KSU_a572q.zip ascendia META-INF
mv Ascendia_3.2_KSU_a572q.zip ../v3/3.2/Ascendia_3.2_KSU_a572q.zip
