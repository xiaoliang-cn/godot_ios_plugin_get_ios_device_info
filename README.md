# godot_ios_plugin_get_ios_device_info
an godot ios plugin example

Since the built file is too large to upload, you need to build it yourself

## how build it

chmod +x ./build.sh

./build.sh

When the build is complete, copy the bin file into the Godot project bin folder, and then configure the IOSDeviceInfoLibrary.gdextension file

## create IOSDeviceInfoLibrary.gdextension file
```
[configuration]
entry_symbol = "swift_entry_point"
compatibility_minimum = 4.2

[libraries]
ios.debug = "res://bin/IOSDeviceInfoLibrary.framework"

[dependencies]
ios.debug = {"res://bin/SwiftGodot.framework": ""}
```
## How to use it
```
  if ClassDB.class_exists("IOSDeviceInfoLibrary"):
		var lib = ClassDB.instantiate("IOSDeviceInfoLibrary");
		var info = lib.get_app_device_info();
        print(info)
	else:
		print("not font IOSDeviceInfoLibrary")
```

If you are not satisfied with the information you get, you can edit the source code and then build your own library
