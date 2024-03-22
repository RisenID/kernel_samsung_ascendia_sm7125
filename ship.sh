#!/bin/bash

cd ../builds/ascendia/pack_ksu/
sed -i -e 's/3.1.1/3.1.2/g' META-INF/com/google/android/update-binary
zip -r Ascendia_3.1.2_KSU_a572q.zip ascendia META-INF
mv Ascendia_3.1.2_KSU_a572q.zip ../v3/3.1.2/Ascendia_3.1.2_KSU_a572q.zip
