# `locales-launch` Remote Part
This remote part ships the `locales-launch` launcher to your snap, this launcher fixes Glibc locales support and allows GNU Gettext-based internationalization(I18N) to work.

![example of gettext support](screenshots/example-gettext-support.png)

## How to use?
### Essential
Merge the following snapcraft recipe:

```yaml
parts:
  locales-launch:
```

and prepend `locales-launch` to the snap application command chain:

```yaml
apps:
  _app_name_:
    command: locales-launch _original_app_command_chain_
```

If you want to generate the locale data in runtime for once per snap installation, that's all you have to do, but if you want to directly embed the full set of pre-compiled locale data without generating them at runtime and don't care about snap size increase by ~7MiB, override the `stage-packages` key to stage the `locales-all` package:


```yaml
parts:
  locales-launch:
    stage-packages:
    - locales-all
```

The launcher will automatically use the in-snap locale data if found.

### GNU Gettext-specific Fixes
Due to the fact that the gettext library doesn't support locating the localization data from a non-fixed location additional modifications are required to make I18N work.

For example for software using the GNU build system the following modification is usually necessary:

```yaml  
parts:
  _part_name_:
    configflags:
    - --datarootdir=/snap/$SNAPCRAFT_PROJECT_NAME/current/share

    organize:
      snap/$SNAPCRAFT_PROJECT_NAME/current: /
```

## NOTE
This launcher is not necessary if the snap target is a GUI application and you're using the `desktop-*` remote part and the `desktop-launch` launcher.  This remote part is primarily for CLI applications.
