#!/bin/bash

PATH_IM_REFACT='/Users/rainfool/WorkSpaceHuYa/kiwi-android_im_refact_feature'
PATH_IM_REFACT_APK='/Users/rainfool/WorkSpaceHuYa/kiwi-android_im_refact_feature/app/kiwi/build/outputs/apk'

PATH_MAINLINE='/Users/rainfool/WorkSpaceHuYa/kiwi-android_mainline_feature'
PATH_MAINLINE_APK='/Users/rainfool/WorkSpaceHuYa/kiwi-android_mainline_feature/app/kiwi/build/outputs/apk'

NAME_APK='yygamelive-5.6.0-SNAPSHOT-0-official.apk'

if [[ $1 = *"main"* ]]; then
  echo 'Param is mainline'
  path_gradle=$PATH_MAINLINE
  path_apk=$PATH_MAINLINE_APK
elif [[ $1 = *"im"* ]]; then
  echo 'Param is im_refact'
  path_gradle=$PATH_IM_REFACT
  path_apk=$PATH_IM_REFACT_APK
else
  echo 'You are MISSING params,it can be [main,im]'
  exit 0
fi

echo $path_gradle
cd $path_gradle

echo '----------asseming debug apk ...'
./gradlew assemDebug
echo '----------gradle build done----------'
echo ' '
echo 'cd apk dir'
cd $path_apk

adb push $NAME_APK /data/local/tmp
echo 'Installing...'
adb shell pm install -r /data/local/tmp/$NAME_APK
adb shell rm /data/local/tmp/$NAME_APK

echo 'Install done,open activity'
adb shell am start -a android.intent.action.MAIN -c android.intent.category.LAUNCHER -n com.duowan.kiwi/.simpleactivity.SplashActivity
terminal-notifier -title 'Build APK script done' -message 'APK编译完成,点击回到Android Studio' -activate 'com.google.android.studio'
