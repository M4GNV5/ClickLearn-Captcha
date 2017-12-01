#!/bin/bash

src=$(curl "https://schueler.click-learn.info/PasswortVergessen")
imgId=$(echo "$src" | grep -Eo '\/Captcha\?anforderung=.*"' | head -n1 | cut -d'=' -f2)
imgId=${imgId::-1}

curl "https://schueler.click-learn.info/Captcha\?anforderung=$imgId" > captcha.png
python thresh.py

convert num1.png num1.tiff
convert num2.png num2.tiff

tesseract num1.tiff digits -psm 7 tesseract_config
num1=$(cat digits.txt)
tesseract num2.tiff digits -psm 7 tesseract_config
num2=$(cat digits.txt)

sum=$(awk "BEGIN{print $num1+$num2}")
if [ $? -eq 0 ]; then
	prefix="${sum}_${num1}_${num2}"
else
	prefix="fail"
fi

mv captcha.png "captchas/${prefix}_$imgId.png"
