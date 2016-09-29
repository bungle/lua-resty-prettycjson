# Change Log

All notable changes to `lua-resty-prettycjson` will be documented in this file.

## [1.6] - 2016-09-29
### Added
- Support for the official OpenResty package manager (opm).

### Changed
- Changed the change log format to keep-a-changelog.

## [1.5] - 2016-03-23
### Fixed
- Now works even if Lua cJSON is not available.

## [1.4] - 2016-04-23
### Added
- Feature: Allow custom encoding function. See also:
  https://github.com/bungle/lua-resty-prettycjson/issues/3
  https://github.com/bungle/lua-resty-prettycjson/pull/4
  https://github.com/bungle/lua-resty-prettycjson/pull/5
  Thanks @vadi2

## [1.3] - 2015-09-30
### Changed
- Only double quoted strings (JSON doesn't use single quotes) are
  checked now.

## [1.2] - 2015-09-29
### Fixed
- Fixes string handling See also:
  https://github.com/bungle/lua-resty-prettycjson/issues/2
  Thanks @irmiab

### Changed
- Uses now string.len / string.sub instead of string.gmatch See also:
  https://github.com/bungle/lua-resty-prettycjson/pull/1
  Thanks @antonheryanto

## [1.1] - 2015-09-29
### Changed
- Removed unneccessary concat call.
- Made code more tight

## [1.0] - 2015-09-28
### Added
- LuaRocks support via MoonRocks.