# Variables for package directories
CORE := $(wildcard packages/core/*)
COMMON := $(wildcard packages/common/*)

# Color codes for output (if your terminal supports them)
RED := \033[0;31m
GREEN := \033[0;32m
AMBER := \033[0;33m
NO_COLOR := \033[0m

# Generic header for rules
define print_header
    echo "\n$(GREEN)*** $(1) ***$(NO_COLOR)\n"
endef

# Generic rule for running a command in each package
define run_in_packages
	for dir in $(1); do \
		echo "\n\n$(GREEN) Entering $${dir} $(NO_COLOR)" ; \
		cd $${dir} && $(2) && cd ../../../ ; \
	done
endef

run_tests:
	$(call print_header,Running tests...)
	flutter test
	$(call run_in_packages, $(CORE) $(COMMON),flutter test)


run_integration_tests:
	$(call print_header,Running integration tests...)
	flutter test integration_test

# Install dependencies
get:
	$(call print_header,Updating dependencies)
	flutter pub get
	$(call run_in_packages,$(CORE) $(COMMON),flutter pub get)

# Enhanced upgrade rule
upgrade:
	$(call print_header,Upgrading dependencies)
	flutter pub upgrade
	$(call run_in_packages,$(CORE) $(COMMON),flutter pub upgrade)

# Override lint rule to handle errors
lint:
	$(call print_header,Linting code...)
	flutter analyze
	$(call run_in_packages,$(CORE) $(COMMON),flutter analyze)

flutter_clean:
	$(call print_header,Cleaning project...)
	flutter clean
	$(call run_in_packages,$(CORE) $(COMMON),flutter clean)

pods-clean:
	rm -Rf ios/Pods ; \
	rm -Rf ios/.symlinks ; \
	rm -Rf ios/Flutter/Flutter.framework ; \
	rm -Rf ios/Flutter/Flutter.podspec ; \
	rm ios/Podfile.lock ; \

build:
	$(call print_header,Building Mocks...)
	flutter pub run build_runner build
	$(call run_in_packages,$(CORE) $(COMMON), flutter pub run build_runner build);\

compile_ios_app:
	$(call print_header,Creating iOS build)
	flutter build ipa; \

compile_android_app:
	$(call print_header,Creating Android build)
	flutter build apk; \

compile_macos_app:
	$(call print_header,Creating Android build)
	flutter build macos; \

open_android_folder_build:
	$(call print_header,Oppening APK folder)
	open build/app/outputs/flutter-apk/;\

open_ios_folder_build:
	$(call print_header,Oppening APK folder)
	open build/ios/archive;\

open_macos_folder_build:
	$(call print_header,Oppening APK folder)
	open macos/Runner.xcworkspace


create-android-app: compile_android_app open_android_folder_build
create-ios-app: compile_ios_app open_ios_folder_build
create-macos-app: compile_macos_app open_macos_folder_build
tests: build run_tests
integration_tests: run_integration_tests

clean: flutter_clean pods-clean


