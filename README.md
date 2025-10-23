# godot_ios_plugin_get_ios_device_info
an godot ios plugin example
You can directly copy the bin and import it into the bin folder in your Godot project，
Of course, you can also build your own。

## How to use it
```
  if ClassDB.class_exists("IOSDeviceInfoLibrary"):
		var lib = ClassDB.instantiate("IOSDeviceInfoLibrary");
		var info = lib.get_app_device_info();
    print(info)
	else:
		print("not font IOSDeviceInfoLibrary")
```

If you are not satisfied with the information you get, you can edit the source code and build your own library
