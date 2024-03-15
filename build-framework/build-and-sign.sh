# For every *.dylib file in dylibs/, create a framework for it
# and copy it to out/


mkdir -p out

info_plist_template='
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>BuildMachineOSBuild</key>
	<string>18C54</string>
	<key>CFBundleDevelopmentRegion</key>
	<string>en</string>
	<key>CFBundleExecutable</key>
	<string>{libname}</string>
	<key>CFBundleIdentifier</key>
	<string>{sanatised_libname}</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>{libname}</string>
	<key>CFBundlePackageType</key>
	<string>FMWK</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0</string>
	<key>CFBundleSupportedPlatforms</key>
	<array>
		<string>iPhoneOS</string>
	</array>
	<key>CFBundleVersion</key>
	<string>1</string>
	<key>DTCompiler</key>
	<string>com.apple.compilers.llvm.clang.1_0</string>
	<key>DTPlatformBuild</key>
	<string>16B91</string>
	<key>DTPlatformName</key>
	<string>iphoneos</string>
	<key>DTPlatformVersion</key>
	<string>14.0</string>
	<key>DTSDKBuild</key>
	<string>16B91</string>
	<key>DTSDKName</key>
	<string>iphoneos</string>
	<key>DTXcode</key>
	<string>1010</string>
	<key>DTXcodeBuild</key>
	<string>10B61</string>
	<key>MinimumOSVersion</key>
	<string>15.0</string>
	<key>UIDeviceFamily</key>
	<array>
		<integer>1</integer>
		<integer>2</integer>
	</array>
</dict>
</plist>
'

# lipo -create libffi.framework/libffi.8.dylib -output libffi.framework/libffi
# rm libffi.framework/libffi.8.dylib
# codesign --force --sign YOUR_IDENTITY 

for lib in "libjli" "libjvm" "libattach" "libj2pcsc" "liblcms" "libawt" "libj2pkcs11" "libmanagement" "libawt_headless" "libjaas_unix" "libmlib_image" "libdt_socket" "libjava" "libnet" "libffi.8" "libjava_crw_demo" "libnio" "libfontmanager" "libjawt" "libnpt" "libfreetype" "libjdwp" "libsunec" "libhprof" "libjpeg" "libunpack" "libinstrument" "libjsdt" "libverify" "libj2gss" "libjsig" "libzip"
  do
	sanatised_libname=$(echo $lib | sed 's/_//g')
	mkdir -p out/$lib.framework
	codesign --force --sign YOUR_IDENTITY --identifier $sanatised_libname dylibs/$lib.dylib
    lipo -create dylibs/$lib.dylib -output out/$lib.framework/$lib
    # Write the Info.plist file
	# sanitise the libname to remove underscores
	echo "$info_plist_template" | sed "s/{libname}/$lib/g" | sed "s/{sanatised_libname}/$sanatised_libname/g" > out/$lib.framework/Info.plist
  done