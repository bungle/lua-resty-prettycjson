package = "lua-resty-prettycjson"
version = "dev-1"
source = {
    url = "git://github.com/bungle/lua-resty-prettycjson.git"
}
description = {
    summary = "JSON Pretty Formatter for Lua cJSON",
    detailed = "lua-resty-prettycjson is a JSON Pretty Formatter for Lua cJSON.",
    homepage = "https://github.com/bungle/lua-resty-prettycjson",
    maintainer = "Aapo Talvensaari <aapo.talvensaari@gmail.com>",
    license = "BSD"
}
dependencies = {
    "lua >= 5.1"
}
build = {
    type = "builtin",
    modules = {
        ["resty.prettycjson"] = "lib/resty/prettycjson.lua"
    }
}
