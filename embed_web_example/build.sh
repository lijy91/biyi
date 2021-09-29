#!/usr/bin/env bash

# 编译 biyi_app
cd ../
flutter build web --profile
rm -rf embed_web_example/biyi_app_web
mv build/web embed_web_example/biyi_app_web