#!/bin/bash

# This ensures that relative paths are correct no matter where the script is executed
cd "$(dirname "$0")"

echo "⚙️  Building project in order to obtain xcodebuild.log"
xcodebuild -workspace ../StudentChrono.xcworkspace -scheme ../StudentChrono > ../xcodebuild.log

echo "⚙️  Running SwiftLint Static Analyzer"
swiftlint analyze --config ../swiftlint.yml --compiler-log-path ../xcodebuild.log
