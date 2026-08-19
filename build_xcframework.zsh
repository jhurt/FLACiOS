#!/bin/zsh
set -e

# Descriptive variables for the build process
project_name="FLACiOS"
output_directory="./build"
xcframework_output="./${project_name}.xcframework"

# Clean previous builds to prevent stale data
rm -rf "${output_directory}"
rm -rf "${xcframework_output}"

echo "Building for iOS Device..."
xcodebuild build \
  -project "${project_name}.xcodeproj" \
  -scheme "${project_name}" \
  -sdk iphoneos \
  -configuration Release \
  BUILD_DIR="${output_directory}" \
  QUIET=YES

echo "Building for iOS Simulator..."
xcodebuild build \
  -project "${project_name}.xcodeproj" \
  -scheme "${project_name}" \
  -sdk iphonesimulator \
  -configuration Release \
  BUILD_DIR="${output_directory}" \
  QUIET=YES

echo "Creating XCFramework..."
xcodebuild -create-xcframework \
  -framework "${output_directory}/Release-iphoneos/${project_name}.framework" \
  -framework "${output_directory}/Release-iphonesimulator/${project_name}.framework" \
  -output "${xcframework_output}"

echo "Success! ${xcframework_output} has been generated."
