local gmatch = string.gmatch
local concat = table.concat
local rep = string.rep
local json = require "cjson.safe".encode

return function(j, l, d, e)
    local s = json(j)
    local i, j, k  = 1, 0, 0
    local r = {}
    local p
    l = l or "\n"
    d = d or "\t"
    e = e or " "
    for c in gmatch(s, ".") do
        if c == "{" then
            if p == ":" then
                r[i] = concat{ "{", l }
            else
                r[i] = concat{ rep(d, j), "{", l }
            end
            j = j + 1
        elseif c == "}" then
            j = j - 1
            if p == "{" then
                i = i - 1
                r[i] = concat{ rep(d, j), "{}" }
            else
                r[i] = concat{ l, rep(d, j), "}" }
            end
        elseif c == "," then
            r[i] = concat{ ",", l }
            k = -1
        elseif c == ":" then
            r[i] = concat{ ":", e }
        elseif c == "[" then
            if p == ":" then
                r[i] = concat{ "[", l }
            else
                r[i] = concat{ rep(d, j), "[", l }
            end
            j = j + 1
        elseif c == "]" then
            j = j - 1
            r[i] = concat{ l, rep(d, j), "]" }
        else
            if j ~= k then
                r[i] = concat{ rep(d, j) }
                i = i + 1
                k = j
            end
            r[i] = c
        end
        p = c
        i = i + 1
    end
    return concat(r)
end
