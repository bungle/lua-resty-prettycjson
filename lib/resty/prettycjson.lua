local gmatch = string.gmatch
local concat = table.concat
local sub = string.sub
local rep = string.rep
local json = require "cjson.safe".encode

return function(tbl, lf, id, ac)
    local s, e = json(tbl)
    if not s then return s, e end
    lf, id, ac = lf or "\n", id or "\t", ac or " "
    local i, j, k, r, p  = 1, 0, 0, {}, nil
    local al = sub(ac, -1) == "\n"
    for c in gmatch(s, ".") do
        if c == "{" or c == "[" then
            r[i] = p == ":" and concat{ c, lf } or concat{ rep(id, j), c, lf }
            j = j + 1
        elseif c == "}" or c == "]" then
            j = j - 1
            if p == "{" or p == "[" then
                i = i - 1
                r[i] = concat{ rep(id, j), p, c }
            else
                r[i] = concat{ lf, rep(id, j), c }
            end
        elseif c == "," then
            r[i] = concat{ c, lf }
            k = -1
        elseif c == ":" then
            r[i] = concat{ c, ac }
            if al then
                i = i + 1
                r[i] = rep(id, j)
            end
        else
            if j ~= k then
                r[i] = rep(id, j)
                i, k = i + 1, j
            end
            r[i] = c
        end
        p, i = c, i + 1
    end
    return concat(r)
end
