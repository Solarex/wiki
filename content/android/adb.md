---
title: "adb"
date: 2014-06-11 23:31
---
## adb ##
Android Debug Bridge (adb) is a versatile command line tool that lets you communicate with an emulator instance or connected Android-powered device. It is a client-server program that includes three components:
  - A client, which runs on your development machine. You can invoke a client from a shell by issuing an adb command. Other Android tools such as the ADT plugin and DDMS also create adb clients.
  - A server, which runs as a background process on your development machine. The server manages communication between the client and the adb daemon running on an emulator or device.
  - A daemon, which runs as a background process on each emulator or device instance.


+ ``adb devices``
+ ``adb install test.apk``
+ ``adb uninstall org.solarex.test``
+ ``adb emu -s emulator-5554 kill``

## adb shell am (ActivityManager) ##

```bash
# am help
usage: am [subcommand] [options]
usage: am start [-D] [-W] [-P <FILE>] [--start-profiler <FILE>] [-S] <INTENT>
am startservice <INTENT>
am force-stop <PACKAGE>
am broadcast <INTENT>
am instrument [-r] [-e <NAME> <VALUE>] [-p <FILE>] [-w]
[--no-window-animation] <COMPONENT>
am profile [looper] start <PROCESS> <FILE>
am profile [looper] stop [<PROCESS>]
am dumpheap [flags] <PROCESS> <FILE>
am monitor [--gdb <port>]
am screen-compat [on|off] <PACKAGE>
am display-size [reset|MxN]

am start: start an Activity.  Options are:
-D: enable debugging
-W: wait for launch to complete
--start-profiler <FILE>: start profiler and send results to <FILE>
-P <FILE>: like above, but profiling stops when app goes idle
-S: force stop the target app before starting the activity

am startservice: start a Service.

am force-stop: force stop everything associated with <PACKAGE>.

am broadcast: send a broadcast Intent.

am instrument: start an Instrumentation.  Typically this target <COMPONENT>
is the form <TEST_PACKAGE>/<RUNNER_CLASS>.  Options are:
-r: print raw results (otherwise decode REPORT_KEY_STREAMRESULT).  Use with
[-e perf true] to generate raw output for performance measurements.
-e <NAME> <VALUE>: set argument <NAME> to <VALUE>.  For test runners a
common form is [-e <testrunner_flag> <value>[,<value>...]].
-p <FILE>: write profiling data to <FILE>
-w: wait for instrumentation to finish before returning.  Required for
test runners.
--no-window-animation: turn off window animations will running.

am profile: start and stop profiler on a process.

am dumpheap: dump the heap of a process.  Options are:
-n: dump native heap instead of managed heap

am monitor: start monitoring for crashes or ANRs.
--gdb: start gdbserv on the given port at crash/ANR

am screen-compat: control screen compatibility mode of <PACKAGE>.

am display-size: override display size.

<INTENT> specifications include these flags and arguments:
[-a <ACTION>] [-d <DATA_URI>] [-t <MIME_TYPE>]
[-c <CATEGORY> [-c <CATEGORY>] ...]
[-e|--es <EXTRA_KEY> <EXTRA_STRING_VALUE> ...]
[--esn <EXTRA_KEY> ...]
[--ez <EXTRA_KEY> <EXTRA_BOOLEAN_VALUE> ...]
[--ei <EXTRA_KEY> <EXTRA_INT_VALUE> ...]
[--el <EXTRA_KEY> <EXTRA_LONG_VALUE> ...]
[--eu <EXTRA_KEY> <EXTRA_URI_VALUE> ...]
[--eia <EXTRA_KEY> <EXTRA_INT_VALUE>[,<EXTRA_INT_VALUE...]]
[--ela <EXTRA_KEY> <EXTRA_LONG_VALUE>[,<EXTRA_LONG_VALUE...]]
[-n <COMPONENT>] [-f <FLAGS>]
[--grant-read-uri-permission] [--grant-write-uri-permission]
[--debug-log-resolution] [--exclude-stopped-packages]
[--include-stopped-packages]
[--activity-brought-to-front] [--activity-clear-top]
[--activity-clear-when-task-reset] [--activity-exclude-from-recents]
[--activity-launched-from-history] [--activity-multiple-task]
[--activity-no-animation] [--activity-no-history]
[--activity-no-user-action] [--activity-previous-is-top]
[--activity-reorder-to-front] [--activity-reset-task-if-needed]
[--activity-single-top] [--activity-clear-task]
[--activity-task-on-home]
[--receiver-registered-only] [--receiver-replace-pending]
[<URI> | <PACKAGE> | <COMPONENT>]

Error: Unknown command: help
```

## adb shell pm (PackageManager) ##

```bash
# pm help
Error: unknown command 'help'
usage: pm list packages [-f] [-d] [-e] [-s] [-e] [-u] [FILTER]
pm list permission-groups
pm list permissions [-g] [-f] [-d] [-u] [GROUP]
pm list instrumentation [-f] [TARGET-PACKAGE]
pm list features
pm list libraries
pm path PACKAGE
pm install [-l] [-r] [-t] [-i INSTALLER_PACKAGE_NAME] [-s] [-f] PATH
pm uninstall [-k] PACKAGE
pm clear PACKAGE
pm enable PACKAGE_OR_COMPONENT
pm disable PACKAGE_OR_COMPONENT
pm disable-user PACKAGE_OR_COMPONENT
pm set-install-location [0/auto] [1/internal] [2/external]
pm get-install-location
pm createUser USER_NAME
pm removeUser USER_ID

pm list packages: prints all packages, optionally only
those whose package name contains the text in FILTER.  Options:
-f: see their associated file.
-d: filter to only show disbled packages.
-e: filter to only show enabled packages.
-s: filter to only show system packages.
-3: filter to only show third party packages.
-u: also include uninstalled packages.

pm list permission-groups: prints all known permission groups.

pm list permissions: prints all known permissions, optionally only
those in GROUP.  Options:
-g: organize by group.
-f: print all information.
-s: short summary.
-d: only list dangerous permissions.
-u: list only the permissions users will see.

pm list instrumentation: use to list all test packages; optionally
supply <TARGET-PACKAGE> to list the test packages for a particular
application.  Options:
-f: list the .apk file for the test package.

pm list features: prints all features of the system.

pm path: print the path to the .apk of the given PACKAGE.

pm install: installs a package to the system.  Options:
-l: install the package with FORWARD_LOCK.
-r: reinstall an exisiting app, keeping its data.
-t: allow test .apks to be installed.
-i: specify the installer package name.
-s: install package on sdcard.
-f: install package on internal flash.

pm uninstall: removes a package from the system. Options:
-k: keep the data and cache directories around after package removal.

pm clear: deletes all data associated with a package.

pm enable, disable, disable-user: these commands change the enabled state
of a given package or component (written as "package/class").

pm get-install-location: returns the current install location.
0 [auto]: Let system decide the best location
1 [internal]: Install on internal device storage
2 [external]: Install on external media

pm set-install-location: changes the default install location.
NOTE: this is only intended for debugging; using this can cause
applications to break and other undersireable behavior.
0 [auto]: Let system decide the best location
1 [internal]: Install on internal device storage
2 [external]: Install on external media
```
