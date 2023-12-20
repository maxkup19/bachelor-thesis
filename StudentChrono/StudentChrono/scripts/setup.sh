#!/bin/bash

# This ensures that relative paths are correct no matter where the script is executed
cd "$(dirname "$0")"

echo "⚙️  Checking file header"
if [ ! -f ../StudentChrono.xcworkspace/xcuserdata/`whoami`.xcuserdatad/IDETemplateMacros.plist ]; then
  echo "❌ File header is not set - setting now"
  echo -n "Enter your full name: "
  read fullname
  mkdir -p ../StudentChrono.xcworkspace/xcuserdata/`whoami`.xcuserdatad
  cp IDETemplateMacros.plist ../StudentChrono.xcworkspace/xcuserdata/`whoami`.xcuserdatad/
  sed -i "" -e "s/___FULLNAME___/$fullname/g" ../StudentChrono.xcworkspace/xcuserdata/`whoami`.xcuserdatad/IDETemplateMacros.plist
else
  echo "✅ File header is properly set"
fi

echo "⚙️  Checking whether Twine is installed"
if command -v twine &> /dev/null; then
  echo "✅ Twine is installed"
else
  echo "❌ Twine is not installed"
  echo "Check https://github.com/MateeDevs/wiki/blob/master/tooling/ruby.md for more info"
fi
