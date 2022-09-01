return (function()
    local lollIIIIlIl = "\108"
    local lollIIIIlIl = "\108"
    local lollIIIIlIl = "\108"
    local lollIIllllI = 47
    local lollIIlllIl = 298
    local lollIIlllII = 3
    local lollIIlIllI = function(a)
        local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
        a = string.gsub(a, "[^" .. b .. "=]", "")
        return a:gsub(
            ".",
            function(c)
                if c == "=" then
                    return ""
                end
                local d, e = "", b:find(c) - 1
                for f = 6, 1, -1 do
                    d = d .. (e % 2 ^ f - e % 2 ^ (f - 1) > 0 and "1" or "0")
                end
                return d
            end
        ):gsub(
            "%d%d%d?%d?%d?%d?%d?%d?",
            function(c)
                if #c ~= 8 then
                    return ""
                end
                local g = 0
                for f = 1, 8 do
                    g = g + (c:sub(f, f) == "1" and 2 ^ (8 - f) or 0)
                end
                return string.char(g)
            end
        )
    end
    local lollIIlllIl = 45
    local lollIIlIlIl = (function()
        local function a(b)
            local c = {}
            for d = 0, 255 do
                c[d] = {}
            end
            c[0][0] = b[1] * 255
            local e = 1
            for f = 0, 7 do
                for d = 0, e - 1 do
                    for g = 0, e - 1 do
                        local h = c[d][g] - b[1] * e
                        c[d][g + e] = h + b[2] * e
                        c[d + e][g] = h + b[3] * e
                        c[d + e][g + e] = h + b[4] * e
                    end
                end
                e = e * 2
            end
            return c
        end
        local i = a {0, 1, 1, 0}
        local function j(self, k)
            local l, d, g = self.S, self.i, self.j
            local m = {}
            local n = string.char
            for o = 1, k do
                d = (d + 1) % 256
                g = (g + l[d]) % 256
                l[d], l[g] = l[g], l[d]
                m[o] = n(l[(l[d] + l[g]) % 256])
            end
            self.i, self.j = d, g
            return table.concat(m)
        end
        local function p(self, q)
            local r = j(self, #q)
            local s = {}
            local t = string.byte
            local n = string.char
            for d = 1, #q do
                s[d] = n(i[t(q, d)][t(r, d)])
            end
            return table.concat(s)
        end
        local function u(self, v)
            local l = self.S
            local g, w = 0, #v
            local t = string.byte
            for d = 0, 255 do
                g = (g + l[d] + t(v, d % w + 1)) % 256
                l[d], l[g] = l[g], l[d]
            end
        end
        function new(v)
            local l = {}
            local s = {S = l, i = 0, j = 0, generate = j, cipher = p, schedule = u}
            for d = 0, 255 do
                l[d] = d
            end
            if v then
                s:schedule(v)
            end
            return s
        end
        return new
    end)()
    local fev = getfenv or function()
            return _ENV
        end
    local lollIIlIlII =
        (function()
        if not bit then
            local bit_ = nil
            pcall(
                function()
                    bit_ = require("bit")
                end
            )
            bit = bit_
        end
        local bit =
            bit or bit32 or
            (function()
                local a = {_TYPE = "module", _NAME = "bit.numberlua", _VERSION = "0.3.1.20120131"}
                local b = math.floor
                local c = 2 ^ 32
                local d = c - 1
                local function e(f)
                    local g = {}
                    local h = setmetatable({}, g)
                    function g:__index(i)
                        local j = f(i)
                        h[i] = j
                        return j
                    end
                    return h
                end
                local function k(h, l)
                    local function m(n, o)
                        local p, q = 0, 1
                        while n ~= 0 and o ~= 0 do
                            local r, s = n % l, o % l
                            p = p + h[r][s] * q
                            n = (n - r) / l
                            o = (o - s) / l
                            q = q * l
                        end
                        p = p + (n + o) * q
                        return p
                    end
                    return m
                end
                local function t(h)
                    local u = k(h, 2 ^ 1)
                    local v =
                        e(
                        function(n)
                            return e(
                                function(o)
                                    return u(n, o)
                                end
                            )
                        end
                    )
                    return k(v, 2 ^ (h.n or 1))
                end
                function a.tobit(w)
                    return w % 2 ^ 32
                end
                a.bxor = t {[0] = {[0] = 0, [1] = 1}, [1] = {[0] = 1, [1] = 0}, n = 4}
                local x = a.bxor
                function a.bnot(n)
                    return d - n
                end
                local y = a.bnot
                function a.band(n, o)
                    return (n + o - x(n, o)) / 2
                end
                local z = a.band
                function a.bor(n, o)
                    return d - z(d - n, d - o)
                end
                local A = a.bor
                local B, C
                function a.rshift(n, D)
                    if D < 0 then
                        return B(n, -D)
                    end
                    return b(n % 2 ^ 32 / 2 ^ D)
                end
                C = a.rshift
                function a.lshift(n, D)
                    if D < 0 then
                        return C(n, -D)
                    end
                    return n * 2 ^ D % 2 ^ 32
                end
                B = a.lshift
                function a.tohex(w, E)
                    E = E or 8
                    local F
                    if E <= 0 then
                        if E == 0 then
                            return ""
                        end
                        F = true
                        E = -E
                    end
                    w = z(w, 16 ^ E - 1)
                    return ("%0" .. E .. (F and "X" or "x")):format(w)
                end
                local G = a.tohex
                function a.extract(E, H, I)
                    I = I or 1
                    return z(C(E, H), 2 ^ I - 1)
                end
                local J = a.extract
                function a.replace(E, j, H, I)
                    I = I or 1
                    local K = 2 ^ I - 1
                    j = z(j, K)
                    local L = y(B(K, H))
                    return z(E, L) + B(j, H)
                end
                local M = a.replace
                function a.bswap(w)
                    local n = z(w, 0xff)
                    w = C(w, 8)
                    local o = z(w, 0xff)
                    w = C(w, 8)
                    local N = z(w, 0xff)
                    w = C(w, 8)
                    local O = z(w, 0xff)
                    return B(B(B(n, 8) + o, 8) + N, 8) + O
                end
                local P = a.bswap
                function a.rrotate(w, D)
                    D = D % 32
                    local Q = z(w, 2 ^ D - 1)
                    return C(w, D) + B(Q, 32 - D)
                end
                local R = a.rrotate
                function a.lrotate(w, D)
                    return R(w, -D)
                end
                local S = a.lrotate
                a.rol = a.lrotate
                a.ror = a.rrotate
                function a.arshift(w, D)
                    local T = C(w, D)
                    if w >= 0x80000000 then
                        T = T + B(2 ^ D - 1, 32 - D)
                    end
                    return T
                end
                local U = a.arshift
                function a.btest(w, V)
                    return z(w, V) ~= 0
                end
                a.bit32 = {}
                local function W(w)
                    return (-1 - w) % c
                end
                a.bit32.bnot = W
                local function X(n, o, N, ...)
                    local T
                    if o then
                        n = n % c
                        o = o % c
                        T = x(n, o)
                        if N then
                            T = X(T, N, ...)
                        end
                        return T
                    elseif n then
                        return n % c
                    else
                        return 0
                    end
                end
                a.bit32.bxor = X
                local function Y(n, o, N, ...)
                    local T
                    if o then
                        n = n % c
                        o = o % c
                        T = (n + o - x(n, o)) / 2
                        if N then
                            T = Y(T, N, ...)
                        end
                        return T
                    elseif n then
                        return n % c
                    else
                        return d
                    end
                end
                a.bit32.band = Y
                local function Z(n, o, N, ...)
                    local T
                    if o then
                        n = n % c
                        o = o % c
                        T = d - z(d - n, d - o)
                        if N then
                            T = Z(T, N, ...)
                        end
                        return T
                    elseif n then
                        return n % c
                    else
                        return 0
                    end
                end
                a.bit32.bor = Z
                function a.bit32.btest(...)
                    return Y(...) ~= 0
                end
                function a.bit32.lrotate(w, D)
                    return S(w % c, D)
                end
                function a.bit32.rrotate(w, D)
                    return R(w % c, D)
                end
                function a.bit32.lshift(w, D)
                    if D > 31 or D < -31 then
                        return 0
                    end
                    return B(w % c, D)
                end
                function a.bit32.rshift(w, D)
                    if D > 31 or D < -31 then
                        return 0
                    end
                    return C(w % c, D)
                end
                function a.bit32.arshift(w, D)
                    w = w % c
                    if D >= 0 then
                        if D > 31 then
                            return w >= 0x80000000 and d or 0
                        else
                            local T = C(w, D)
                            if w >= 0x80000000 then
                                T = T + B(2 ^ D - 1, 32 - D)
                            end
                            return T
                        end
                    else
                        return B(w, -D)
                    end
                end
                function a.bit32.extract(w, H, ...)
                    local I = ... or 1
                    if H < 0 or H > 31 or I < 0 or H + I > 32 then
                        error "out of range"
                    end
                    w = w % c
                    return J(w, H, ...)
                end
                function a.bit32.replace(w, j, H, ...)
                    local I = ... or 1
                    if H < 0 or H > 31 or I < 0 or H + I > 32 then
                        error "out of range"
                    end
                    w = w % c
                    j = j % c
                    return M(w, j, H, ...)
                end
                a.bit = {}
                function a.bit.tobit(w)
                    w = w % c
                    if w >= 0x80000000 then
                        w = w - c
                    end
                    return w
                end
                local _ = a.bit.tobit
                function a.bit.tohex(w, ...)
                    return G(w % c, ...)
                end
                function a.bit.bnot(w)
                    return _(y(w % c))
                end
                local function a0(n, o, N, ...)
                    if N then
                        return a0(a0(n, o), N, ...)
                    elseif o then
                        return _(A(n % c, o % c))
                    else
                        return _(n)
                    end
                end
                a.bit.bor = a0
                local function a1(n, o, N, ...)
                    if N then
                        return a1(a1(n, o), N, ...)
                    elseif o then
                        return _(z(n % c, o % c))
                    else
                        return _(n)
                    end
                end
                a.bit.band = a1
                local function a2(n, o, N, ...)
                    if N then
                        return a2(a2(n, o), N, ...)
                    elseif o then
                        return _(x(n % c, o % c))
                    else
                        return _(n)
                    end
                end
                a.bit.bxor = a2
                function a.bit.lshift(w, E)
                    return _(B(w % c, E % 32))
                end
                function a.bit.rshift(w, E)
                    return _(C(w % c, E % 32))
                end
                function a.bit.arshift(w, E)
                    return _(U(w % c, E % 32))
                end
                function a.bit.rol(w, E)
                    return _(S(w % c, E % 32))
                end
                function a.bit.ror(w, E)
                    return _(R(w % c, E % 32))
                end
                function a.bit.bswap(w)
                    return _(P(w % c))
                end
                return a
            end)()
        local unpack = table.unpack or unpack
        local a3
        local a4
        local a5
        local a6 = 50
        local a7 = {
            [22] = 18,
            [31] = 8,
            [33] = 28,
            [0] = 3,
            [1] = 13,
            [2] = 23,
            [26] = 33,
            [12] = 1,
            [13] = 6,
            [14] = 10,
            [15] = 16,
            [16] = 20,
            [17] = 26,
            [18] = 30,
            [19] = 36,
            [3] = 0,
            [4] = 2,
            [5] = 4,
            [6] = 7,
            [7] = 9,
            [8] = 12,
            [9] = 14,
            [10] = 17,
            [20] = 19,
            [21] = 22,
            [23] = 24,
            [24] = 27,
            [25] = 29,
            [27] = 32,
            [32] = 34,
            [34] = 37,
            [11] = 5,
            [28] = 11,
            [29] = 15,
            [30] = 21,
            [35] = 25,
            [36] = 31,
            [37] = 35
        }
        local a8 = {
            [0] = "ABC",
            "ABx",
            "ABC",
            "ABC",
            "ABC",
            "ABx",
            "ABC",
            "ABx",
            "ABC",
            "ABC",
            "ABC",
            "ABC",
            "ABC",
            "ABC",
            "ABC",
            "ABC",
            "ABC",
            "ABC",
            "ABC",
            "ABC",
            "ABC",
            "ABC",
            "AsBx",
            "ABC",
            "ABC",
            "ABC",
            "ABC",
            "ABC",
            "ABC",
            "ABC",
            "ABC",
            "AsBx",
            "AsBx",
            "ABC",
            "ABC",
            "ABC",
            "ABx",
            "ABC"
        }
        local a9 = {
            [0] = {b = "OpArgR", c = "OpArgN"},
            {b = "OpArgK", c = "OpArgN"},
            {b = "OpArgU", c = "OpArgU"},
            {b = "OpArgR", c = "OpArgN"},
            {b = "OpArgU", c = "OpArgN"},
            {b = "OpArgK", c = "OpArgN"},
            {b = "OpArgR", c = "OpArgK"},
            {b = "OpArgK", c = "OpArgN"},
            {b = "OpArgU", c = "OpArgN"},
            {b = "OpArgK", c = "OpArgK"},
            {b = "OpArgU", c = "OpArgU"},
            {b = "OpArgR", c = "OpArgK"},
            {b = "OpArgK", c = "OpArgK"},
            {b = "OpArgK", c = "OpArgK"},
            {b = "OpArgK", c = "OpArgK"},
            {b = "OpArgK", c = "OpArgK"},
            {b = "OpArgK", c = "OpArgK"},
            {b = "OpArgK", c = "OpArgK"},
            {b = "OpArgR", c = "OpArgN"},
            {b = "OpArgR", c = "OpArgN"},
            {b = "OpArgR", c = "OpArgN"},
            {b = "OpArgR", c = "OpArgR"},
            {b = "OpArgR", c = "OpArgN"},
            {b = "OpArgK", c = "OpArgK"},
            {b = "OpArgK", c = "OpArgK"},
            {b = "OpArgK", c = "OpArgK"},
            {b = "OpArgR", c = "OpArgU"},
            {b = "OpArgR", c = "OpArgU"},
            {b = "OpArgU", c = "OpArgU"},
            {b = "OpArgU", c = "OpArgU"},
            {b = "OpArgU", c = "OpArgN"},
            {b = "OpArgR", c = "OpArgN"},
            {b = "OpArgR", c = "OpArgN"},
            {b = "OpArgN", c = "OpArgU"},
            {b = "OpArgU", c = "OpArgU"},
            {b = "OpArgN", c = "OpArgN"},
            {b = "OpArgU", c = "OpArgN"},
            {b = "OpArgU", c = "OpArgN"}
        }
        local function aa(ab, s, e, d)
            local ac = 0
            for i = s, e, d do
                ac = ac + string.byte(ab, i, i) * 256 ^ (i - s)
            end
            return ac
        end
        local function ad(ae, af, ag, ah)
            local ai = (-1) ^ bit.rshift(ah, 7)
            local aj = bit.rshift(ag, 7) + bit.lshift(bit.band(ah, 0x7F), 1)
            local ak = ae + bit.lshift(af, 8) + bit.lshift(bit.band(ag, 0x7F), 16)
            local al = 1
            if aj == 0 then
                if ak == 0 then
                    return ai * 0
                else
                    al = 0
                    aj = 1
                end
            elseif aj == 0x7F then
                if ak == 0 then
                    return ai * 1 / 0
                else
                    return ai * 0 / 0
                end
            end
            return ai * 2 ^ (aj - 127) * (1 + al / 2 ^ 23)
        end
        local function am(ae, af, ag, ah, an, ao, ap, aq)
            local ai = (-1) ^ bit.rshift(aq, 7)
            local aj = bit.lshift(bit.band(aq, 0x7F), 4) + bit.rshift(ap, 4)
            local ak = bit.band(ap, 0x0F) * 2 ^ 48
            local al = 1
            ak = ak + ao * 2 ^ 40 + an * 2 ^ 32 + ah * 2 ^ 24 + ag * 2 ^ 16 + af * 2 ^ 8 + ae
            if aj == 0 then
                if ak == 0 then
                    return ai * 0
                else
                    al = 0
                    aj = 1
                end
            elseif aj == 0x7FF then
                if ak == 0 then
                    return ai * 1 / 0
                else
                    return ai * 0 / 0
                end
            end
            return ai * 2 ^ (aj - 1023) * (al + ak / 2 ^ 52)
        end
        local function ar(ab, s, e)
            return aa(ab, s, e - 1, 1)
        end
        local function as(ab, s, e)
            return aa(ab, e - 1, s, -1)
        end
        local function at(ab, s)
            return ad(string.byte(ab, s, s + 3))
        end
        local function au(ab, s)
            local ae, af, ag, ah = string.byte(ab, s, s + 3)
            return ad(ah, ag, af, ae)
        end
        local function av(ab, s)
            return am(string.byte(ab, s, s + 7))
        end
        local function aw(ab, s)
            local ae, af, ag, ah, an, ao, ap, aq = string.byte(ab, s, s + 7)
            return am(aq, ap, ao, an, ah, ag, af, ae)
        end
        local ax = {[4] = {little = at, big = au}, [8] = {little = av, big = aw}}
        local function ay(S)
            local az = S.index
            local aA = string.byte(S.source, az, az)
            S.index = az + 1
            return aA
        end
        local function aB(S, aC)
            local aD = S.index + aC
            local aE = string.sub(S.source, S.index, aD - 1)
            S.index = aD
            return aE
        end
        local function aF(S)
            local aC = S:s_szt()
            local aE
            if aC ~= 0 then
                aE = string.sub(aB(S, aC), 1, -2)
            end
            return aE
        end
        local function aG(aC, aH)
            return function(S)
                local aD = S.index + aC
                local aI = aH(S.source, S.index, aD)
                S.index = aD
                return aI
            end
        end
        local function aJ(aC, aH)
            return function(S)
                local aK = aH(S.source, S.index)
                S.index = S.index + aC
                return aK
            end
        end
        local function aL(S)
            local aM = S:s_int()
            local aN = {}
            for i = 1, aM do
                local aO = S:s_ins()
                local aP = bit.band(aO, 0x3F)
                local aQ = a8[aP]
                local aR = a9[aP]
                local aS = {value = aO, op = a7[aP], A = bit.band(bit.rshift(aO, 6), 0xFF)}
                if aQ == "ABC" then
                    aS.B = bit.band(bit.rshift(aO, 23), 0x1FF)
                    aS.C = bit.band(bit.rshift(aO, 14), 0x1FF)
                    aS.is_KB = aR.b == "OpArgK" and aS.B > 0xFF
                    aS.is_KC = aR.c == "OpArgK" and aS.C > 0xFF
                elseif aQ == "ABx" then
                    aS.Bx = bit.band(bit.rshift(aO, 14), 0x3FFFF)
                    aS.is_K = aR.b == "OpArgK"
                elseif aQ == "AsBx" then
                    aS.sBx = bit.band(bit.rshift(aO, 14), 0x3FFFF) - 131071
                end
                aN[i] = aS
            end
            return aN
        end
        local function aT(S)
            local aM = S:s_int()
            local aU = {}
            for i = 1, aM do
                local aV = ay(S)
                local k
                if aV == 1 then
                    k = ay(S) ~= 0
                elseif aV == 3 then
                    k = S:s_num()
                elseif aV == 4 then
                    k = aF(S)
                end
                aU[i] = k
            end
            return aU
        end
        local function aW(S, ab)
            local aM = S:s_int()
            local aX = {}
            for i = 1, aM do
                aX[i] = a5(S, ab)
            end
            return aX
        end
        local function aY(S)
            local aM = S:s_int()
            local aZ = {}
            for i = 1, aM do
                aZ[i] = S:s_int()
            end
            return aZ
        end
        local function a_(S)
            local aM = S:s_int()
            local b0 = {}
            for i = 1, aM do
                b0[i] = {varname = aF(S), startpc = S:s_int(), endpc = S:s_int()}
            end
            return b0
        end
        local function b1(S)
            local aM = S:s_int()
            local b2 = {}
            for i = 1, aM do
                b2[i] = aF(S)
            end
            return b2
        end
        function a5(S, b3)
            local b4 = {}
            local ab = aF(S) or b3
            b4.source = ab
            S:s_int()
            S:s_int()
            b4.numupvals = ay(S)
            b4.numparams = ay(S)
            ay(S)
            ay(S)
            b4.code = aL(S)
            b4.const = aT(S)
            b4.subs = aW(S, ab)
            b4.lines = aY(S)
            a_(S)
            b1(S)
            for _, v in ipairs(b4.code) do
                if v.is_K then
                    v.const = b4.const[v.Bx + 1]
                else
                    if v.is_KB then
                        v.const_B = b4.const[v.B - 0xFF]
                    end
                    if v.is_KC then
                        v.const_C = b4.const[v.C - 0xFF]
                    end
                end
            end
            return b4
        end
        function a3(ab)
            local b5
            local b6
            local b7
            local b8
            local b9
            local ba
            local bb
            local bc = {index = 1, source = ab}
            assert(aB(bc, 4) == "\27Lua", "invalid Lua signature")
            assert(ay(bc) == 0x51, "invalid Lua version")
            assert(ay(bc) == 0, "invalid Lua format")
            b6 = ay(bc) ~= 0
            b7 = ay(bc)
            b8 = ay(bc)
            b9 = ay(bc)
            ba = ay(bc)
            bb = ay(bc) ~= 0
            b5 = b6 and ar or as
            bc.s_int = aG(b7, b5)
            bc.s_szt = aG(b8, b5)
            bc.s_ins = aG(b9, b5)
            if bb then
                bc.s_num = aG(ba, b5)
            elseif ax[ba] then
                bc.s_num = aJ(ba, ax[ba][b6 and "little" or "big"])
            else
                error("unsupported float size")
            end
            return a5(bc, "@virtual")
        end
        local function bd(be, bf)
            for i, bg in pairs(be) do
                if bg.index >= bf then
                    bg.value = bg.store[bg.index]
                    bg.store = bg
                    bg.index = "value"
                    be[i] = nil
                end
            end
        end
        local function bh(be, bf, bi)
            local bj = be[bf]
            if not bj then
                bj = {index = bf, store = bi}
                be[bf] = bj
            end
            return bj
        end
        local function bk(...)
            return select("#", ...), {...}
        end
        local function bl(bm, bn)
            local ab = bm.source
            local bo = bm.lines[bm.pc - 1]
            local b3, bp, bq = string.match(bn, "^(.-):(%d+):%s+(.+)")
            local br = "%s:%i: [%s:%i] %s"
            bo = bo or "0"
            b3 = b3 or "?"
            bp = bp or "0"
            bq = bq or bn
            error(string.format(br, ab, bo, b3, bp, bq), 0)
        end
        local function bs(bm)
            local aN = bm.code
            local bt = bm.subs
            local bu = bm.env
            local bv = bm.upvals
            local bw = bm.varargs
            local bx = -1
            local by = {}
            local bi = bm.stack
            local bz = bm.pc
            while true do
                local bA = aN[bz]
                local aP = bA.op
                bz = bz + 1
                if aP < 18 then
                    if aP < 8 then
                        if aP < 3 then
                            if aP < 1 then
                                for i = bA.A, bA.B do
                                    bi[i] = nil
                                end
                            elseif aP > 1 then
                                local bg = bv[bA.B]
                                bi[bA.A] = bg.store[bg.index]
                            else
                                local bB, bC
                                if bA.is_KB then
                                    bB = bA.const_B
                                else
                                    bB = bi[bA.B]
                                end
                                if bA.is_KC then
                                    bC = bA.const_C
                                else
                                    bC = bi[bA.C]
                                end
                                bi[bA.A] = bB + bC
                            end
                        elseif aP > 3 then
                            if aP < 6 then
                                if aP > 4 then
                                    local A = bA.A
                                    local B = bA.B
                                    local bf
                                    if bA.is_KC then
                                        bf = bA.const_C
                                    else
                                        bf = bi[bA.C]
                                    end
                                    bi[A + 1] = bi[B]
                                    bi[A] = bi[B][bf]
                                else
                                    bi[bA.A] = bu[bA.const]
                                end
                            elseif aP > 6 then
                                local bf
                                if bA.is_KC then
                                    bf = bA.const_C
                                else
                                    bf = bi[bA.C]
                                end
                                bi[bA.A] = bi[bA.B][bf]
                            else
                                local bB, bC
                                if bA.is_KB then
                                    bB = bA.const_B
                                else
                                    bB = bi[bA.B]
                                end
                                if bA.is_KC then
                                    bC = bA.const_C
                                else
                                    bC = bi[bA.C]
                                end
                                bi[bA.A] = bB - bC
                            end
                        else
                            bi[bA.A] = bi[bA.B]
                        end
                    elseif aP > 8 then
                        if aP < 13 then
                            if aP < 10 then
                                bu[bA.const] = bi[bA.A]
                            elseif aP > 10 then
                                if aP < 12 then
                                    local A = bA.A
                                    local B = bA.B
                                    local C = bA.C
                                    local bD
                                    local bE, bF
                                    if B == 0 then
                                        bD = bx - A
                                    else
                                        bD = B - 1
                                    end
                                    bE, bF = bk(bi[A](unpack(bi, A + 1, A + bD)))
                                    if C == 0 then
                                        bx = A + bE - 1
                                    else
                                        bE = C - 1
                                    end
                                    for i = 1, bE do
                                        bi[A + i - 1] = bF[i]
                                    end
                                else
                                    local bg = bv[bA.B]
                                    bg.store[bg.index] = bi[bA.A]
                                end
                            else
                                local bB, bC
                                if bA.is_KB then
                                    bB = bA.const_B
                                else
                                    bB = bi[bA.B]
                                end
                                if bA.is_KC then
                                    bC = bA.const_C
                                else
                                    bC = bi[bA.C]
                                end
                                bi[bA.A] = bB * bC
                            end
                        elseif aP > 13 then
                            if aP < 16 then
                                if aP > 14 then
                                    local A = bA.A
                                    local B = bA.B
                                    local bD
                                    if B == 0 then
                                        bD = bx - A
                                    else
                                        bD = B - 1
                                    end
                                    bd(by, 0)
                                    return bk(bi[A](unpack(bi, A + 1, A + bD)))
                                else
                                    local bf, bG
                                    if bA.is_KB then
                                        bf = bA.const_B
                                    else
                                        bf = bi[bA.B]
                                    end
                                    if bA.is_KC then
                                        bG = bA.const_C
                                    else
                                        bG = bi[bA.C]
                                    end
                                    bi[bA.A][bf] = bG
                                end
                            elseif aP > 16 then
                                bi[bA.A] = {}
                            else
                                local bB, bC
                                if bA.is_KB then
                                    bB = bA.const_B
                                else
                                    bB = bi[bA.B]
                                end
                                if bA.is_KC then
                                    bC = bA.const_C
                                else
                                    bC = bi[bA.C]
                                end
                                bi[bA.A] = bB / bC
                            end
                        else
                            bi[bA.A] = bA.const
                        end
                    else
                        local A = bA.A
                        local bH = bi[A + 2]
                        local bf = bi[A] + bH
                        local bI = bi[A + 1]
                        local bJ
                        if bH == math.abs(bH) then
                            bJ = bf <= bI
                        else
                            bJ = bf >= bI
                        end
                        if bJ then
                            bi[bA.A] = bf
                            bi[bA.A + 3] = bf
                            bz = bz + bA.sBx
                        end
                    end
                elseif aP > 18 then
                    if aP < 28 then
                        if aP < 23 then
                            if aP < 20 then
                                bi[bA.A] = #bi[bA.B]
                            elseif aP > 20 then
                                if aP < 22 then
                                    local A = bA.A
                                    local B = bA.B
                                    local bK = {}
                                    local aM
                                    if B == 0 then
                                        aM = bx - A + 1
                                    else
                                        aM = B - 1
                                    end
                                    for i = 1, aM do
                                        bK[i] = bi[A + i - 1]
                                    end
                                    bd(by, 0)
                                    return aM, bK
                                else
                                    local aE = bi[bA.B]
                                    for i = bA.B + 1, bA.C do
                                        aE = aE .. bi[i]
                                    end
                                    bi[bA.A] = aE
                                end
                            else
                                local bB, bC
                                if bA.is_KB then
                                    bB = bA.const_B
                                else
                                    bB = bi[bA.B]
                                end
                                if bA.is_KC then
                                    bC = bA.const_C
                                else
                                    bC = bi[bA.C]
                                end
                                bi[bA.A] = bB % bC
                            end
                        elseif aP > 23 then
                            if aP < 26 then
                                if aP > 24 then
                                    bd(by, bA.A)
                                else
                                    local bB, bC
                                    if bA.is_KB then
                                        bB = bA.const_B
                                    else
                                        bB = bi[bA.B]
                                    end
                                    if bA.is_KC then
                                        bC = bA.const_C
                                    else
                                        bC = bi[bA.C]
                                    end
                                    if bB == bC == (bA.A ~= 0) then
                                        bz = bz + aN[bz].sBx
                                    end
                                    bz = bz + 1
                                end
                            elseif aP > 26 then
                                local bB, bC
                                if bA.is_KB then
                                    bB = bA.const_B
                                else
                                    bB = bi[bA.B]
                                end
                                if bA.is_KC then
                                    bC = bA.const_C
                                else
                                    bC = bi[bA.C]
                                end
                                if bB < bC == (bA.A ~= 0) then
                                    bz = bz + aN[bz].sBx
                                end
                                bz = bz + 1
                            else
                                local bB, bC
                                if bA.is_KB then
                                    bB = bA.const_B
                                else
                                    bB = bi[bA.B]
                                end
                                if bA.is_KC then
                                    bC = bA.const_C
                                else
                                    bC = bi[bA.C]
                                end
                                bi[bA.A] = bB ^ bC
                            end
                        else
                            bi[bA.A] = bA.B ~= 0
                            if bA.C ~= 0 then
                                bz = bz + 1
                            end
                        end
                    elseif aP > 28 then
                        if aP < 33 then
                            if aP < 30 then
                                local bB, bC
                                if bA.is_KB then
                                    bB = bA.const_B
                                else
                                    bB = bi[bA.B]
                                end
                                if bA.is_KC then
                                    bC = bA.const_C
                                else
                                    bC = bi[bA.C]
                                end
                                if bB <= bC == (bA.A ~= 0) then
                                    bz = bz + aN[bz].sBx
                                end
                                bz = bz + 1
                            elseif aP > 30 then
                                if aP < 32 then
                                    local aX = bt[bA.Bx + 1]
                                    local bL = aX.numupvals
                                    local bM
                                    if bL ~= 0 then
                                        bM = {}
                                        for i = 1, bL do
                                            local bN = aN[bz + i - 1]
                                            if bN.op == a7[0] then
                                                bM[i - 1] = bh(by, bN.B, bi)
                                            elseif bN.op == a7[4] then
                                                bM[i - 1] = bv[bN.B]
                                            end
                                        end
                                        bz = bz + bL
                                    end
                                    bi[bA.A] = a4(aX, bu, bM)
                                else
                                    local A = bA.A
                                    local B = bA.B
                                    if not bi[B] == (bA.C ~= 0) then
                                        bz = bz + 1
                                    else
                                        bi[A] = bi[B]
                                    end
                                end
                            else
                                bi[bA.A] = -bi[bA.B]
                            end
                        elseif aP > 33 then
                            if aP < 36 then
                                if aP > 34 then
                                    local A = bA.A
                                    local aM = bA.B
                                    if aM == 0 then
                                        aM = bw.size
                                        bx = A + aM - 1
                                    end
                                    for i = 1, aM do
                                        bi[A + i - 1] = bw.list[i]
                                    end
                                else
                                    local A = bA.A
                                    local bO, bI, bH
                                    bO = assert(tonumber(bi[A]), "`for` initial value must be a number")
                                    bI = assert(tonumber(bi[A + 1]), "`for` limit must be a number")
                                    bH = assert(tonumber(bi[A + 2]), "`for` step must be a number")
                                    bi[A] = bO - bH
                                    bi[A + 1] = bI
                                    bi[A + 2] = bH
                                    bz = bz + bA.sBx
                                end
                            elseif aP > 36 then
                                local A = bA.A
                                local C = bA.C
                                local aM = bA.B
                                local bP = bi[A]
                                local bQ
                                if aM == 0 then
                                    aM = bx - A
                                end
                                if C == 0 then
                                    C = bA[bz].value
                                    bz = bz + 1
                                end
                                bQ = (C - 1) * a6
                                for i = 1, aM do
                                    bP[i + bQ] = bi[A + i]
                                end
                            else
                                bi[bA.A] = not bi[bA.B]
                            end
                        else
                            if not bi[bA.A] == (bA.C ~= 0) then
                                bz = bz + 1
                            end
                        end
                    else
                        local A = bA.A
                        local aH = bi[A]
                        local bR = bi[A + 1]
                        local bf = bi[A + 2]
                        local bS = A + 3
                        local bK
                        bi[bS + 2] = bf
                        bi[bS + 1] = bR
                        bi[bS] = aH
                        bK = {aH(bR, bf)}
                        for i = 1, bA.C do
                            bi[bS + i - 1] = bK[i]
                        end
                        if bi[bS] ~= nil then
                            bi[A + 2] = bi[bS]
                        else
                            bz = bz + 1
                        end
                    end
                else
                    bz = bz + bA.sBx
                end
                bm.pc = bz
            end
        end
        function a4(bR, bu, b2)
            local bT = bR.code
            local bU = bR.subs
            local bV = bR.lines
            local bW = bR.source
            local bX = bR.numparams
            local function bY(...)
                local bi = {}
                local bZ = {}
                local b_ = 0
                local c0, c1 = bk(...)
                local bm
                local c2, bn, bK
                for i = 1, bX do
                    bi[i - 1] = c1[i]
                end
                if bX < c0 then
                    b_ = c0 - bX
                    for i = 1, b_ do
                        bZ[i] = c1[bX + i]
                    end
                end
                bm = {
                    varargs = {list = bZ, size = b_},
                    code = bT,
                    subs = bU,
                    lines = bV,
                    source = bW,
                    env = bu,
                    upvals = b2,
                    stack = bi,
                    pc = 1
                }
                c2, bn, bK = pcall(bs, bm, ...)
                if c2 then
                    return unpack(bK, 1, bn)
                else
                    bl(bm, bn)
                end
                return
            end
            return bY
        end
        return function(c3, bu)
            return a4(a3(c3), bu or fev(0))
        end
    end)()
    local lollIIllIll = "\101\108\73\57\77\88\78\110\76\49\115\108\85\81\61\61"
    local lollIIlIIIl =
        "\109\89\71\113\67\83\80\55\78\81\105\87\89\66\90\56\116\72\65\56\89\102\100\51\74\71\113\79\85\51\57\111\82\70\49\103\43\88\88\54\103\107\54\49\65\80\97\83\110\77\73\115\103\107\97\80\117\107\81\49\88\86\105\77\48\105\109\53\71\50\98\67\112\105\66\68\68\112\74\67\73\84\89\83\49\55\121\98\70\114\70\79\66\102\110\47\65\65\101\82\82\65\112\117\82\68\100\99\69\74\71\69\107\80\87\55\68\84\49\113\116\120\120\65\66\108\55\97\106\43\81\67\106\113\51\78\103\103\67\102\67\101\73\51\83\76\114\56\122\106\70\78\112\103\52\83\76\82\53\99\90\117\57\69\104\120\104\108\115\70\65\54\121\121\119\90\98\116\121\83\85\53\55\116\119\82\107\50\49\112\121\78\56\43\66\77\116\109\66\73\75\71\72\65\117\52\97\73\68\50\100\102\111\54\111\50\113\55\47\86\57\113\108\106\83\108\79\84\66\72\74\102\89\72\106\102\65\89\102\55\88\86\73\49\120\121\72\65\47\101\120\54\49\48\48\99\85\80\86\65\68\57\80\111\70\106\69\114\88\67\80\84\43\106\54\106\56\75\88\112\121\83\57\89\103\113\106\114\118\77\43\101\51\70\90\47\81\103\68\78\111\113\101\122\71\74\51\105\49\72\76\121\122\108\111\117\99\110\98\119\43\75\82\109\54\105\118\111\88\70\78\117\72\65\111\97\79\82\52\90\53\109\81\50\51\84\65\100\82\82\97\113\78\99\115\80\106\50\101\50\98\69\67\107\69\52\43\79\116\69\122\106\80\90\55\71\101\120\112\55\86\48\84\53\120\54\78\109\54\89\86\88\74\78\110\77\66\121\72\101\119\68\120\119\70\121\56\81\76\114\73\104\71\110\109\109\106\84\112\69\100\99\104\111\97\88\51\48\112\86\70\72\84\100\97\119\54\103\72\115\105\65\78\102\115\75\77\68\71\53\111\114\84\66\69\90\90\109\85\90\54\80\85\47\121\119\47\114\72\54\101\118\57\72\57\89\116\87\101\98\108\84\106\81\114\116\117\89\116\90\66\118\104\65\73\122\68\74\87\85\107\105\112\118\52\98\90\86\98\67\122\115\51\86\56\120\68\88\115\78\102\77\68\79\52\97\110\85\107\66\106\80\122\66\84\116\120\70\99\72\52\120\70\119\105\105\82\99\121\77\76\120\119\71\86\83\87\71\79\110\85\73\72\97\100\121\52\78\100\79\112\97\121\120\75\57\75\111\81\47\77\54\102\113\99\101\99\55\89\117\43\106\79\114\76\47\43\72\116\50\104\82\113\56\111\53\114\109\102\75\79\107\55\85\112\81\109\53\102\77\68\111\54\106\121\67\52\78\65\113\78\106\105\107\75\47\81\112\115\105\104\72\107\104\110\67\115\105\97\69\104\85\109\119\79\90\105\112\72\119\77\117\67\118\74\78\112\50\112\117\97\97\83\75\80\121\84\87\81\100\102\73\108\66\53\65\49\116\86\55\73\66\87\72\101\90\98\73\100\115\119\50\88\85\110\72\88\81\118\83\47\99\51\72\47\49\67\73\120\109\79\65\50\54\88\108\116\120\71\98\66\83\118\105\47\48\109\108\88\51\113\86\113\100\82\53\67\69\66\53\47\70\69\83\54\109\75\78\83\119\68\103\78\119\102\66\109\56\54\84\75\97\85\79\84\122\90\83\47\74\99\48\81\84\87\66\49\50\116\85\120\122\53\99\119\47\76\70\89\57\67\85\110\76\118\77\73\109\51\65\104\98\66\109\112\74\84\67\84\54\81\85\120\53\67\56\113\72\72\82\56\104\110\80\86\115\108\85\77\107\108\108\71\102\117\122\89\80\113\115\103\71\74\70\105\121\100\78\99\100\68\53\51\115\100\53\79\48\78\104\100\76\112\84\105\114\98\81\66\114\97\52\109\79\87\79\52\68\104\98\69\48\71\74\87\80\90\79\84\68\99\77\66\69\109\110\48\115\57\57\71\97\117\89\105\73\103\119\56\50\55\86\109\111\108\121\69\99\88\85\83\69\98\114\113\70\76\67\99\73\79\102\99\105\88\100\80\113\87\57\71\57\115\89\103\101\112\100\75\102\77\87\107\87\70\75\69\83\108\83\109\80\56\89\98\113\54\49\56\51\81\108\108\111\73\71\118\113\77\56\55\48\80\108\89\121\85\99\85\65\48\113\87\53\50\101\98\56\53\109\115\122\80\103\52\113\57\101\43\97\52\114\84\56\106\109\88\54\105\118\48\70\122\111\70\84\66\88\107\68\54\55\51\56\99\51\82\52\53\83\82\115\43\49\54\79\105\65\65\108\50\73\89\67\48\68\83\77\88\113\49\87\43\120\56\98\113\75\120\120\85\43\79\73\110\56\65\54\53\107\71\90\102\47\71\121\103\85\108\117\86\89\122\118\76\97\76\111\52\81\111\113\80\66\80\111\71\119\56\65\109\50\115\115\98\53\122\78\73\79\74\100\49\56\101\65\69\67\50\74\87\112\67\74\104\112\99\104\78\102\54\79\109\111\87\122\67\70\81\111\72\97\74\79\86\56\47\71\84\70\119\119\98\121\82\110\50\98\56\51\114\97\87\114\110\99\51\119\54\103\97\117\54\54\112\83\89\50\111\65\109\114\113\109\106\90\52\109\115\72\56\79\86\113\48\83\117\77\83\119\43\77\117\86\101\111\77\98\108\83\115\80\104\57\75\81\43\73\98\111\100\101\108\106\100\85\84\85\113\65\115\88\104\106\106\78\105\70\82\80\49\78\119\79\76\122\51\85\102\104\114\98\115\106\122\70\80\67\81\73\90\106\50\66\68\112\48\53\86\84\116\98\72\43\101\117\122\69\72\111\57\89\100\65\107\89\70\89\53\80\89\77\105\71\43\90\71\106\98\49\88\55\103\89\47\77\115\74\100\117\65\48\119\111\117\102\83\81\97\98\81\53\66\102\79\101\65\79\47\74\71\115\81\77\110\54\83\117\118\107\117\52\43\108\121\87\108\82\77\101\67\74\117\107\105\102\82\112\85\106\76\65\97\100\57\68\88\108\49\54\106\88\99\98\53\113\79\70\48\70\87\67\106\103\72\49\73\99\81\102\109\88\111\121\81\87\69\77\67\43\112\104\84\88\114\103\107\77\47\117\80\73\103\107\54\69\51\87\76\116\70\112\111\73\50\103\122\72\43\79\65\107\56\65\86\101\52\74\118\110\57\72\115\115\116\72\72\80\122\49\78\87\106\112\88\117\113\73\89\82\113\78\71\122\80\79\81\49\116\78\88\65\88\117\120\116\99\119\88\51\110\104\53\82\73\76\86\114\53\97\88\101\107\73\110\69\43\121\105\53\48\88\110\90\116\49\105\54\120\51\86\55\111\99\121\82\54\69\88\116\53\121\88\99\56\105\116\78\112\87\111\49\103\119\103\55\82\99\101\73\52\67\53\54\48\72\67\76\109\76\118\55\112\51\106\54\76\107\113\84\68\53\76\69\101\85\67\109\76\67\98\52\48\79\56\105\83\99\88\110\53\67\107\50\111\79\73\53\47\43\79\50\86\122\71\43\83\102\82\122\48\56\113\116\76\49\113\114\122\115\81\116\104\68\82\83\116\101\51\112\116\78\97\70\108\47\43\122\98\77\110\89\67\112\97\116\104\87\103\81\73\115\50\85\87\83\70\114\120\98\56\99\86\98\50\55\112\116\102\49\107\98\116\90\72\90\103\116\43\102\71\83\101\50\78\118\104\79\83\111\80\67\82\51\89\57\74\43\109\57\87\55\86\47\111\122\86\54\98\48\73\67\122\65\90\114\81\99\82\73\47\85\119\105\113\48\55\106\104\98\52\78\114\109\81\51\118\83\108\69\101\57\77\77\118\114\97\107\74\48\103\73\83\119\73\68\122\121\117\52\68\120\57\69\99\80\52\76\76\65\97\119\102\97\104\109\108\116\51\79\89\67\117\51\79\72\48\54\70\83\114\118\53\73\117\50\120\55\69\53\53\89\97\82\77\78\110\65\48\98\104\110\121\100\108\116\48\104\116\73\77\85\79\116\110\70\86\51\88\82\79\106\85\73\112\55\99\81\87\85\65\80\84\48\47\88\98\84\110\115\119\54\49\118\70\57\122\106\49\47\50\56\122\98\90\104\108\87\49\70\113\105\53\81\48\90\113\71\104\48\100\88\111\88\110\54\104\107\70\121\81\82\100\75\53\47\81\87\43\116\79\90\88\72\74\116\114\119\112\77\51\85\104\82\85\120\43\99\70\86\53\98\105\86\106\85\117\118\74\47\73\79\48\68\67\112\85\51\88\99\49\102\83\53\51\70\109\57\76\109\67\119\115\47\118\50\108\67\78\66\56\104\76\47\97\47\89\121\103\103\72\67\76\106\117\43\74\100\114\122\100\76\113\71\55\66\70\108\43\104\55\43\115\116\101\68\47\52\111\98\99\43\108\69\97\121\76\101\54\114\112\102\43\74\56\71\80\78\86\65\113\100\98\110\97\76\71\51\109\54\68\56\100\77\86\99\102\81\80\68\56\55\121\89\122\88\114\86\54\110\105\99\69\89\76\65\122\85\47\51\73\49\47\118\90\76\115\84\74\122\103\122\74\89\107\74\65\113\109\81\103\111\109\101\100\107\48\73\86\80\110\82\114\88\109\54\116\98\82\78\74\113\110\74\47\54\54\70\115\90\68\50\78\106\112\67\52\103\53\72\68\79\56\109\121\54\110\84\50\68\103\118\55\47\82\98\77\100\101\99\73\68\54\82\56\119\102\55\84\71\108\118\75\78\99\100\79\68\118\109\106\84\101\121\72\103\83\118\102\97\115\85\69\101\52\119\48\57\76\69\108\78\72\119\53\121\85\71\103\111\108\110\107\53\47\121\98\71\111\43\48\84\112\111\69\119\81\49\79\118\79\50\104\54\110\121\79\86\77\57\82\89\78\99\57\98\76\110\77\49\65\104\104\99\115\116\119\72\106\121\87\66\47\69\48\103\75\117\102\51\101\43\98\75\71\103\106\48\120\102\100\113\103\55\74\86\112\110\120\112\86\105\66\97\67\81\51\100\86\74\107\76\110\109\76\87\57\104\88\70\119\75\77\77\51\68\43\119\122\73\115\81\106\57\83\89\55\102\71\122\122\78\49\66\102\105\112\99\68\56\112\76\67\121\51\67\47\71\99\106\65\66\68\98\100\109\114\68\87\110\83\83\97\49\107\121\55\56\67\82\65\121\67\78\85\120\52\75\67\107\82\119\74\107\81\81\102\106\53\122\51\77\65\48\85\100\79\108\75\97\81\114\97\72\66\50\66\121\83\68\43\52\83\116\115\70\55\49\115\100\56\102\101\47\78\51\119\122\110\100\47\101\65\105\65\70\89\74\89\43\98\114\83\112\112\75\103\117\43\68\111\115\67\98\109\65\97\122\53\55\52\85\90\54\89\110\67\83\75\75\115\104\99\105\53\108\53\79\98\56\115\75\84\111\49\78\87\86\77\107\79\57\117\56\121\49\105\65\87\53\108\57\52\98\86\114\120\87\47\55\110\71\71\55\118\66\90\89\99\109\73\50\52\107\56\115\53\47\88\99\82\110\54\90\109\70\102\43\119\119\86\53\110\109\84\87\77\74\113\122\71\85\76\70\89\74\49\50\72\76\72\121\122\65\108\115\110\122\109\90\114\90\105\79\73\115\97\56\97\89\100\112\56\121\114\87\68\53\86\51\108\79\99\120\111\107\51\55\67\78\47\90\89\105\115\70\55\77\88\50\121\69\113\55\88\75\119\100\49\71\74\84\48\68\51\68\114\122\56\103\54\67\80\49\81\53\71\107\112\52\50\121\78\72\55\88\70\79\73\72\101\67\111\86\114\57\112\97\105\80\90\52\76\67\54\71\111\82\43\111\97\117\70\48\106\115\69\67\65\78\70\120\78\109\83\70\104\121\121\111\117\84\105\50\84\89\106\51\105\67\101\102\105\109\113\72\108\76\68\75\120\84\69\69\100\69\87\54\48\121\114\111\73\113\55\67\68\110\86\90\80\54\82\89\78\78\97\99\104\72\55\86\73\86\56\108\121\90\83\72\84\98\70\80\56\57\88\53\78\70\74\43\102\77\67\121\98\85\78\80\100\51\102\67\120\52\69\52\47\89\90\73\120\116\83\54\104\55\107\89\97\115\55\120\82\53\105\50\73\73\120\73\82\83\49\89\80\118\102\55\121\121\112\54\90\106\98\112\109\80\79\106\65\90\74\72\53\102\67\71\73\48\118\48\48\53\82\105\99\104\90\55\49\80\122\87\53\99\99\49\109\78\52\97\70\83\56\50\72\117\110\117\75\107\55\70\57\98\116\54\65\68\99\85\72\48\97\65\99\48\53\115\70\82\69\106\74\109\71\47\101\107\112\107\106\86\88\111\48\84\100\73\57\100\107\53\102\90\113\53\74\47\67\49\73\56\119\87\114\88\110\102\111\52\118\99\100\101\52\65\84\47\54\50\114\66\79\54\74\104\114\67\105\106\89\81\100\104\52\106\78\77\119\105\72\66\122\55\107\118\116\65\104\51\72\66\79\83\50\77\76\48\110\81\102\65\105\119\102\71\71\47\77\88\120\69\71\57\78\71\117\81\99\115\104\103\70\57\66\79\101\55\114\114\65\56\120\119\51\98\57\88\109\86\47\102\47\84\114\111\54\97\105\119\86\50\103\84\117\83\85\101\81\84\87\108\110\110\54\105\77\106\65\56\103\49\104\90\85\87\81\71\104\102\80\89\122\75\105\73\68\109\77\98\115\103\105\109\56\84\70\55\111\90\85\83\43\105\56\86\81\98\50\73\51\68\72\68\119\99\53\84\74\98\68\50\79\79\118\122\98\69\103\52\81\83\102\77\113\53\80\120\108\106\106\101\55\112\121\81\99\101\105\107\67\77\52\75\52\84\98\72\55\73\87\51\79\118\111\118\75\75\67\101\118\113\89\81\43\72\108\102\53\43\66\83\106\69\48\113\99\53\54\90\67\89\54\109\98\71\90\52\117\83\122\70\82\112\100\98\66\66\115\77\76\52\111\115\50\104\104\107\53\50\116\78\50\81\104\99\116\81\74\73\116\118\83\87\105\113\74\88\105\84\71\57\82\65\110\98\111\51\75\84\70\120\114\101\74\68\67\72\90\106\57\122\122\66\43\99\116\72\112\109\52\82\77\80\85\65\99\88\49\107\50\120\56\78\69\52\90\79\56\72\84\113\86\47\47\103\72\56\100\57\87\85\75\87\75\50\76\110\67\117\68\99\52\53\65\66\110\76\98\48\100\109\78\118\101\102\89\99\80\89\108\88\89\86\56\90\108\70\71\112\120\113\55\86\99\119\108\99\81\76\43\70\84\113\82\73\67\43\100\55\113\83\108\121\86\43\98\83\102\65\121\97\54\122\67\49\75\116\112\88\79\51\121\87\116\100\107\100\43\51\88\102\97\73\118\67\122\72\89\79\47\87\75\105\100\71\89\81\122\88\53\83\65\66\115\49\108\71\79\102\100\89\78\72\47\119\72\43\57\104\48\108\121\75\47\66\53\82\121\81\122\67\122\116\112\67\107\86\76\71\100\68\86\53\113\69\66\107\87\105\119\57\75\109\50\48\107\113\80\68\88\106\47\80\118\71\66\113\89\90\65\53\68\65\51\121\43\101\43\51\51\55\54\115\57\109\107\57\119\104\56\69\87\98\84\77\110\47\87\105\102\98\69\50\49\115\90\97\72\121\54\68\65\65\81\84\88\72\103\57\73\65\50\75\110\118\112\79\100\111\78\47\110\121\115\56\114\110\85\67\67\97\101\99\105\83\100\82\113\56\116\101\47\102\111\54\110\50\66\108\53\87\82\121\57\50\112\98\57\72\113\84\53\105\48\73\70\114\70\111\121\72\53\78\115\90\86\73\70\75\69\118\88\117\107\118\65\97\84\70\69\53\50\81\109\65\43\47\114\50\122\115\50\88\97\76\56\119\80\121\83\84\71\81\55\52\88\73\68\65\71\83\56\113\115\77\69\73\102\106\120\112\65\74\114\122\88\81\101\81\109\54\115\43\108\104\118\122\81\67\76\43\70\120\48\99\100\54\84\74\79\113\110\99\68\113\71\109\43\97\71\80\82\103\71\82\48\114\79\110\55\109\49\105\51\108\88\70\83\107\71\43\89\105\72\79\116\107\87\82\79\118\66\47\57\81\78\53\122\82\88\81\81\55\80\121\119\71\112\74\65\71\48\98\84\72\115\53\50\53\57\101\76\116\56\104\52\90\67\53\80\83\69\89\86\118\113\79\74\71\69\73\81\102\51\102\67\76\69\75\102\103\55\108\100\47\109\56\90\85\107\99\71\115\71\114\102\98\104\110\68\67\107\113\66\103\66\113\85\89\120\122\90\107\68\118\72\70\87\109\81\51\105\88\69\54\119\78\114\76\69\53\88\109\50\70\85\79\105\100\104\89\103\105\109\108\98\102\97\89\78\51\48\85\88\86\104\88\67\102\102\109\67\90\107\68\109\122\106\51\48\121\111\48\113\98\83\55\66\51\83\53\71\110\90\107\85\76\79\101\119\47\101\85\100\65\76\112\87\51\109\78\118\43\82\112\98\81\74\71\100\112\97\52\77\115\83\120\81\77\112\117\66\101\110\102\90\65\65\73\104\57\75\121\78\100\90\102\103\75\84\82\74\115\97\115\83\53\107\111\54\76\87\89\114\70\106\80\90\66\70\53\84\56\48\106\118\74\67\51\47\81\106\56\86\89\50\99\56\120\65\78\54\76\114\85\50\66\112\55\47\111\117\71\83\70\117\122\90\100\114\103\47\120\83\72\109\69\73\86\104\114\89\75\106\106\105\89\84\47\69\118\90\100\77\111\52\97\102\120\101\120\90\117\83\108\78\120\76\98\65\73\109\107\110\120\102\111\76\75\86\52\49\103\89\110\84\67\104\113\74\76\65\65\82\52\87\75\90\68\66\106\72\83\71\72\72\71\71\77\66\77\70\55\100\97\101\99\88\99\87\120\54\99\83\75\80\115\107\47\74\65\101\106\43\102\71\53\69\49\108\68\112\75\75\113\49\51\104\78\97\106\107\99\75\49\48\119\76\53\79\105\84\101\84\83\88\122\112\106\48\118\73\57\107\51\69\78\69\73\87\48\97\108\97\86\57\67\83\114\47\78\112\79\51\112\66\86\106\54\112\50\84\74\50\66\67\68\67\102\84\68\108\51\108\66\83\73\103\87\77\116\80\85\69\48\88\65\108\115\50\72\71\121\47\109\116\81\51\66\109\84\85\78\113\73\80\101\71\84\112\110\54\68\86\112\52\68\54\107\68\109\72\84\50\52\56\107\78\72\103\52\72\109\122\83\89\108\113\85\82\50\77\111\53\100\77\53\114\66\85\75\77\53\87\104\76\121\65\81\72\117\103\78\74\80\73\57\57\104\82\83\105\102\102\88\100\72\116\104\54\109\78\121\87\100\57\72\68\71\53\53\119\65\109\54\48\75\89\106\117\82\111\78\104\118\52\87\66\80\87\119\103\89\119\113\121\110\68\72\67\71\85\88\99\57\47\99\74\100\88\47\108\119\74\121\112\120\111\70\69\88\115\51\53\98\73\48\87\121\50\106\99\98\79\74\68\117\90\119\52\100\102\68\81\48\97\90\56\83\90\120\67\83\101\116\87\122\47\106\108\65\108\113\51\106\70\122\55\106\86\77\48\113\99\54\104\69\82\114\97\97\100\105\100\70\55\54\117\56\120\80\50\79\109\66\90\121\109\118\103\57\100\80\101\89\80\105\77\79\106\66\90\55\69\55\108\114\99\97\80\43\81\55\101\115\50\71\111\66\90\73\122\106\55\86\110\75\99\77\74\48\76\49\90\74\110\113\106\89\103\119\79\85\115\48\99\70\69\83\100\86\55\114\98\103\78\76\86\76\73\101\114\117\78\56\105\89\120\115\53\104\68\78\88\115\50\80\114\86\115\105\106\100\70\53\99\66\69\57\75\108\71\73\66\77\50\68\82\102\52\104\79\53\85\106\72\52\50\122\65\90\74\54\114\119\108\105\48\48\122\66\74\73\122\49\83\108\97\54\74\43\120\82\83\85\84\65\74\112\79\79\53\102\50\86\120\106\55\72\79\78\119\105\119\81\120\101\68\77\105\85\76\79\85\51\116\70\99\109\67\118\73\73\56\50\104\65\101\117\70\86\78\84\52\54\49\53\75\100\72\47\73\78\54\87\79\87\71\109\97\107\98\50\113\106\121\82\97\66\106\71\54\68\81\51\52\86\88\90\107\54\43\118\121\103\84\111\113\55\54\84\89\110\109\88\56\66\54\97\90\109\77\72\89\53\105\110\121\105\108\47\72\76\97\85\106\87\43\51\50\68\113\80\97\107\80\75\89\87\53\100\97\72\70\76\74\53\116\78\43\55\66\87\49\121\97\88\54\107\109\111\52\122\98\50\77\100\74\118\48\52\118\73\80\81\43\50\122\78\72\56\109\118\106\103\100\54\110\68\107\81\89\90\65\78\119\66\52\53\66\77\108\113\73\114\105\86\120\50\111\47\110\100\54\50\83\72\82\49\114\75\108\72\68\51\74\121\74\51\109\49\87\115\121\80\54\66\69\89\117\98\76\118\54\67\104\103\122\89\101\47\78\107\52\114\107\108\120\106\84\56\102\78\122\89\117\84\109\75\85\73\117\117\69\101\52\55\66\73\79\70\73\122\67\114\74\81\121\113\110\78\105\73\74\82\86\49\115\68\73\57\90\118\49\76\121\88\52\110\54\67\80\47\73\109\108\75\112\88\55\83\98\86\117\85\49\80\107\53\85\104\89\98\85\108\98\71\82\100\50\72\103\117\73\107\97\47\90\67\66\115\103\57\80\98\113\57\81\80\108\101\111\78\68\101\54\100\80\85\54\113\105\106\79\97\118\67\78\49\112\84\112\69\113\112\76\122\85\107\76\66\81\76\47\52\72\107\110\80\111\76\79\83\70\72\70\86\86\115\73\69\117\113\56\66\67\119\50\55\109\83\79\57\106\54\98\52\99\82\73\69\90\104\115\56\74\81\110\50\85\81\97\100\70\71\88\98\68\78\57\65\51\48\57\102\89\89\80\72\106\65\87\112\100\114\98\112\68\50\83\50\105\81\112\90\115\116\99\110\72\68\79\108\53\108\78\84\119\108\99\109\104\84\108\65\72\57\67\57\107\54\120\78\116\87\47\51\57\105\48\77\88\56\69\75\75\118\119\47\89\69\76\102\88\108\86\112\109\118\47\99\112\103\121\76\111\52\109\43\53\90\79\120\68\118\67\70\117\82\54\113\119\115\106\48\99\48\119\73\99\71\82\48\86\101\56\120\74\84\97\119\57\77\48\104\53\99\120\55\104\111\90\104\81\49\108\121\65\51\100\106\75\98\111\119\111\108\97\114\54\97\48\117\74\82\54\121\80\85\81\84\70\50\72\83\67\85\49\81\107\117\82\119\72\114\119\116\100\88\87\122\110\76\101\120\99\101\87\98\70\83\75\119\117\102\77\70\83\108\49\67\90\111\83\57\116\69\107\120\71\101\109\51\55\55\115\74\72\101\101\43\97\74\106\120\103\106\116\65\77\52\87\77\117\76\122\112\78\86\109\121\115\121\54\78\80\67\66\107\75\118\104\69\85\43\66\53\57\114\85\100\110\55\51\116\43\90\77\55\54\116\86\49\88\47\47\65\116\76\67\90\54\112\70\49\110\79\90\79\51\72\101\97\66\100\79\120\77\88\54\117\55\122\87\107\56\53\67\102\43\104\89\86\108\77\84\57\53\72\50\116\113\121\66\120\78\43\54\68\67\122\107\106\43\99\49\97\75\121\50\57\51\113\112\70\107\79\73\84\57\86\78\117\85\66\114\80\70\119\108\122\87\121\90\98\52\52\75\43\82\114\70\53\102\67\112\73\86\82\110\103\88\49\81\75\103\67\88\104\114\72\55\118\66\84\107\109\73\103\118\118\57\88\75\113\103\53\99\69\66\112\65\88\75\68\110\72\88\65\121\97\109\57\49\48\65\51\118\98\84\116\69\69\120\53\79\89\72\78\67\98\100\122\83\107\49\77\65\115\82\78\70\47\87\48\100\102\110\116\67\51\49\106\85\116\73\69\48\99\75\90\76\102\67\101\104\108\82\112\87\114\89\99\79\57\54\83\112\112\76\109\65\52\117\105\80\113\84\104\113\113\118\87\121\100\106\100\70\67\52\99\89\108\84\84\119\109\105\55\80\87\88\101\120\73\105\77\82\72\72\99\98\79\81\122\118\102\48\119\67\98\49\50\98\52\100\113\116\73\76\101\100\99\114\114\86\110\103\43\121\47\49\121\50\104\112\47\49\118\110\97\102\68\53\67\118\67\85\87\122\43\56\98\65\55\82\119\100\85\99\49\55\102\119\72\82\105\121\52\43\121\120\50\43\118\47\43\49\84\108\78\69\79\101\72\54\56\85\65\66\98\82\105\119\110\88\103\55\114\72\115\103\119\108\105\90\76\98\74\56\106\77\43\83\81\57\88\102\85\85\113\52\114\52\52\43\121\48\109\66\83\108\121\77\75\111\72\85\68\113\121\54\67\57\88\97\117\47\90\84\70\119\122\82\110\87\78\87\81\84\87\71\102\98\105\50\119\69\48\72\113\88\98\75\86\122\85\100\99\54\102\118\51\48\112\52\98\114\102\113\77\72\90\54\47\97\75\69\114\78\116\105\81\69\77\49\67\80\109\99\120\107\75\52\99\99\69\74\76\86\56\122\118\114\73\116\49\90\100\113\113\47\119\70\90\72\56\105\72\86\73\103\82\87\74\109\57\107\120\55\104\103\107\82\103\97\53\55\75\48\86\104\109\113\83\54\73\117\98\101\81\113\78\48\71\122\48\114\102\100\66\74\68\74\104\65\87\65\48\52\117\98\69\79\81\88\79\82\114\119\118\114\73\116\81\122\101\102\114\115\108\112\87\114\54\72\47\47\82\100\50\53\108\115\77\82\43\49\56\122\99\118\50\119\73\99\69\77\75\87\77\80\70\50\53\99\65\72\73\74\88\69\50\114\80\87\102\97\89\106\90\101\73\82\99\97\99\101\115\43\115\110\119\55\82\109\71\47\99\51\53\106\108\80\115\57\119\98\67\71\76\106\98\51\99\112\111\43\84\54\69\108\69\51\74\55\50\72\50\118\113\71\67\115\114\97\48\76\84\100\82\48\106\97\72\114\97\89\101\122\65\75\119\48\75\107\86\71\121\87\81\120\43\113\67\113\100\98\80\98\81\80\120\51\103\52\88\81\101\116\120\56\82\52\103\50\50\118\103\79\71\122\85\112\53\111\57\119\107\68\82\99\87\90\65\79\109\89\69\72\116\81\116\53\98\56\113\99\101\88\100\74\81\88\68\119\75\77\71\47\87\97\112\103\73\110\109\102\47\107\49\54\98\101\98\74\110\118\107\84\111\79\90\117\77\97\73\119\78\89\108\48\97\50\76\51\100\88\51\116\55\73\74\86\76\70\99\98\105\100\118\90\101\81\43\88\54\76\122\55\43\53\118\110\101\121\102\115\71\100\49\120\98\113\48\55\50\65\105\98\43\54\79\76\75\70\81\47\86\48\110\98\89\66\70\102\90\77\78\71\49\47\88\115\66\87\65\86\43\103\106\57\86\101\121\98\114\57\121\98\80\89\52\76\110\56\75\57\113\50\105\104\79\79\49\120\57\75\114\105\97\105\70\101\87\69\47\113\49\54\78\116\84\112\84\116\54\84\104\81\65\108\81\77\76\81\105\117\57\55\112\66\49\76\107\86\105\87\52\102\83\114\107\99\49\112\108\77\73\48\87\67\73\115\104\108\97\120\120\85\75\88\107\84\83\105\103\82\119\54\51\47\47\55\57\81\49\77\113\108\85\101\70\86\65\65\86\103\76\55\80\71\97\73\78\54\105\78\67\117\106\121\47\43\70\103\102\57\89\79\81\76\112\114\121\111\101\49\48\53\109\115\83\80\66\82\78\83\56\109\80\54\48\89\53\83\120\97\98\75\54\84\55\72\66\81\99\100\72\89\82\119\73\119\105\117\57\120\76\47\110\111\118\47\102\77\65\75\84\106\120\76\70\57\68\49\54\117\78\78\83\79\68\47\106\109\114\87\90\112\71\116\122\57\75\72\80\72\100\114\112\115\67\55\103\88\79\83\109\76\67\54\107\55\65\85\114\56\99\106\102\67\117\77\112\101\103\54\112\73\108\106\72\117\122\57\119\106\76\109\47\83\90\88\110\114\113\57\104\85\116\74\65\108\122\100\75\83\90\74\73\50\112\98\72\56\66\77\79\104\116\117\70\71\103\105\67\43\121\109\72\66\116\89\83\119\86\55\87\113\43\43\117\70\54\101\103\52\113\101\84\56\103\85\99\117\80\118\71\112\106\97\119\48\67\65\52\99\79\47\48\106\53\73\65\76\103\121\108\74\85\82\101\109\83\78\48\84\122\81\67\67\98\109\53\77\87\88\120\106\56\105\66\51\116\73\110\67\53\65\109\78\70\119\107\81\89\75\52\108\103\109\105\117\90\97\109\66\118\117\100\107\88\112\74\43\74\79\97\51\84\85\89\116\116\87\110\119\88\82\50\120\71\100\82\118\117\105\79\49\81\66\113\65\50\73\51\89\67\113\90\73\50\100\88\108\97\112\101\103\116\98\53\57\71\75\43\75\112\43\82\82\84\118\120\43\111\77\77\101\43\114\84\83\100\89\47\67\79\52\57\97\55\86\76\70\77\74\79\110\73\82\53\116\73\79\75\66\119\71\98\115\68\75\99\69\103\72\80\111\43\69\56\71\113\87\76\43\82\43\52\87\79\99\122\122\66\87\85\72\99\54\70\68\103\101\115\75\70\107\89\117\108\65\108\56\101\67\73\55\83\43\85\86\54\75\79\107\89\74\116\101\90\50\81\83\117\78\67\87\109\87\97\75\85\100\89\69\43\88\101\86\53\71\43\47\83\56\97\68\99\51\43\69\115\70\67\43\54\74\54\65\72\103\112\104\97\120\55\84\43\72\54\48\88\88\49\56\83\90\71\51\121\68\110\51\97\73\118\79\48\122\87\85\65\80\83\77\82\48\101\83\55\110\49\77\79\53\69\83\102\50\101\101\101\80\106\106\110\117\84\53\56\103\88\55\118\118\78\57\79\111\55\121\99\99\48\77\105\50\109\114\111\49\86\114\107\49\105\116\98\121\100\49\53\66\69\82\87\56\57\65\103\102\98\81\88\104\47\97\67\56\112\57\68\83\121\101\72\98\70\109\71\81\73\67\48\82\90\89\97\97\65\105\118\105\86\119\74\80\117\103\68\120\106\66\89\67\122\114\118\79\80\102\54\57\56\86\77\55\87\88\105\117\102\87\104\50\79\52\71\55\98\106\70\106\49\48\82\89\118\115\55\120\69\99\99\108\107\54\117\79\117\114\101\109\116\49\68\122\90\52\82\99\106\65\118\68\67\57\72\80\100\76\114\82\121\65\43\47\56\99\69\116\105\107\109\77\88\89\97\74\111\116\87\57\55\88\118\47\112\52\72\97\78\75\119\118\69\85\77\67\55\118\106\50\80\116\71\100\99\100\85\109\57\77\56\103\86\72\76\118\50\109\77\121\102\70\106\67\104\53\65\104\90\102\73\70\115\85\66\102\110\78\112\88\106\112\54\48\116\86\105\122\108\75\53\112\78\73\65\75\116\53\78\50\86\118\48\74\90\72\80\102\80\114\49\52\55\116\65\70\80\87\66\105\69\65\112\47\51\77\111\112\55\120\82\50\54\67\100\119\79\66\52\112\98\111\99\50\70\55\116\54\120\78\84\83\97\108\76\82\70\66\101\48\114\116\48\72\65\107\50\47\109\55\121\70\68\110\118\49\108\79\87\99\121\100\73\78\47\85\97\102\121\48\85\111\43\54\70\114\97\81\72\88\111\47\101\84\81\105\116\72\43\90\110\100\48\70\107\43\74\50\103\99\100\65\55\81\66\67\87\114\74\85\119\55\52\74\118\68\118\48\90\78\78\50\105\119\120\56\48\77\49\110\82\68\50\56\47\109\74\82\43\47\47\67\49\80\112\50\81\110\122\82\47\111\114\78\47\119\113\113\114\51\90\122\89\108\67\84\83\90\80\52\112\122\101\54\47\99\90\81\108\72\74\83\100\98\107\118\117\85\109\113\97\57\49\83\74\83\55\71\79\104\118\47\79\57\116\83\53\76\75\48\98\48\118\114\102\100\102\47\82\79\68\112\113\105\69\118\52\51\66\89\90\109\120\67\117\67\83\112\85\55\85\100\98\48\109\90\81\115\56\68\51\87\69\49\112\80\50\97\65\79\114\57\73\56\84\122\116\56\48\77\49\67\57\112\71\72\83\66\106\51\71\50\119\112\122\111\104\120\66\102\81\80\80\52\121\84\56\122\77\97\80\84\113\55\55\111\43\101\109\99\106\83\114\101\43\69\67\122\114\69\90\105\65\84\110\76\111\110\48\75\73\80\75\43\73\113\88\115\84\71\84\55\85\67\55\79\54\52\88\110\70\69\98\122\65\47\100\54\85\98\85\97\69\80\57\87\80\79\105\103\107\119\48\75\110\103\48\115\76\100\51\53\71\108\54\119\116\85\70\106\111\78\119\112\109\103\88\114\116\50\118\106\83\70\102\102\81\55\113\78\86\56\79\106\119\110\52\67\102\99\101\69\79\72\49\43\118\51\99\113\65\121\109\74\105\117\67\65\81\82\76\79\77\86\102\89\119\89\109\54\84\105\81\99\115\112\81\83\114\121\106\51\112\104\116\110\110\57\47\102\65\72\78\70\109\71\103\54\50\115\108\106\107\78\107\102\88\90\43\90\99\72\109\83\119\83\69\117\71\105\56\47\111\103\109\54\116\43\116\99\55\78\50\105\50\47\118\110\115\51\43\74\75\97\69\108\100\83\97\54\78\54\106\120\90\115\97\53\66\110\65\101\119\99\83\104\82\43\57\88\99\106\80\99\97\113\119\68\57\104\88\120\121\48\88\97\84\43\101\87\100\112\115\75\106\66\105\105\77\48\83\87\72\107\102\85\109\119\81\97\51\73\111\109\97\81\122\77\115\81\80\99\103\100\53\85\98\120\103\67\43\53\78\104\48\84\112\104\100\75\103\67\56\99\71\100\53\72\97\114\84\66\110\105\109\47\108\81\70\67\122\81\90\107\98\65\88\121\80\87\83\51\115\103\79\51\86\81\56\68\54\71\87\108\113\104\43\43\85\55\80\98\43\113\76\43\47\70\68\55\43\77\97\106\78\118\67\54\120\114\69\69\108\115\103\71\71\100\77\67\53\115\103\68\80\86\100\98\97\75\67\87\56\48\106\49\47\47\48\83\114\43\111\79\116\69\115\43\114\110\116\122\83\57\67\121\57\97\121\89\43\65\69\65\72\100\109\116\117\81\70\78\99\43\54\50\74\97\51\107\54\49\49\116\118\56\48\86\106\69\104\78\53\51\75\101\73\121\67\106\103\107\72\80\66\103\77\50\113\107\85\81\90\111\108\81\51\104\51\76\66\74\55\103\117\66\118\79\47\105\71\81\79\50\48\83\107\106\53\109\118\90\100\77\54\48\57\57\76\54\112\118\86\57\119\49\87\90\121\87\80\50\114\89\75\110\76\50\85\97\90\75\122\99\70\89\55\121\51\86\50\55\76\65\69\48\85\53\79\117\81\97\49\110\77\52\82\89\116\52\67\51\97\43\84\101\78\103\102\47\47\104\67\67\81\73\97\56\104\55\78\56\55\118\83\80\73\55\113\43\107\83\54\85\70\79\69\113\67\83\67\89\67\97\88\55\84\43\105\74\67\66\97\120\117\77\49\47\68\84\88\101\65\88\77\50\70\86\100\48\51\121\82\69\66\76\66\49\118\52\49\80\87\70\108\103\90\104\90\75\103\54\114\101\67\106\55\76\119\114\98\106\55\88\118\105\107\118\84\55\112\49\69\98\103\107\100\51\73\116\111\116\87\122\121\110\118\119\80\107\98\51\104\77\57\104\97\115\70\100\72\51\47\113\57\100\104\122\122\57\102\72\56\105\114\108\87\112\69\53\84\65\71\101\102\52\66\113\77\108\43\90\109\83\55\48\121\74\67\73\72\117\80\103\89\116\107\111\88\68\54\105\115\49\99\83\55\115\113\55\100\79\85\73\76\57\84\100\119\43\107\56\116\111\109\50\105\113\109\74\76\102\115\47\71\73\106\107\102\101\50\43\48\56\82\117\50\111\108\54\101\71\114\65\85\113\79\56\113\80\89\110\111\105\57\119\71\82\56\105\66\101\109\75\99\102\55\89\50\100\55\112\114\89\102\65\65\86\57\55\114\119\84\73\54\109\74\114\111\56\115\109\99\77\76\85\103\102\76\69\113\48\114\54\90\114\101\105\89\49\101\48\73\84\68\107\50\72\118\76\111\98\99\113\76\67\50\85\79\56\53\69\102\56\109\113\108\54\115\97\108\76\87\72\86\116\122\99\84\75\48\106\81\103\98\73\109\87\55\68\79\119\85\116\52\90\114\78\80\51\52\87\80\70\111\86\121\69\65\54\104\114\117\115\109\104\43\65\111\76\97\47\117\101\71\67\122\110\71\56\108\72\73\117\112\77\106\52\68\86\50\68\101\105\55\114\56\110\75\109\56\69\43\55\72\106\114\108\100\90\102\85\77\89\77\55\99\114\47\52\116\116\105\48\65\100\76\105\103\76\75\67\75\76\115\55\103\49\66\112\67\121\98\77\122\87\50\65\70\99\108\119\81\56\82\101\86\81\57\78\71\56\86\84\106\122\82\98\89\86\119\48\72\111\102\65\83\102\115\67\73\99\122\87\72\70\82\82\83\118\48\113\104\113\48\106\55\80\121\65\86\119\104\122\79\73\52\53\97\49\83\56\99\113\104\114\51\79\119\70\119\89\78\122\103\115\79\72\67\81\71\80\48\114\74\118\69\87\49\52\103\65\98\69\86\105\122\50\87\97\117\97\89\81\99\97\120\107\80\111\71\83\82\84\100\105\108\122\103\107\78\54\117\49\50\106\102\83\87\47\53\78\55\90\113\115\83\100\118\67\98\122\56\48\99\90\75\84\112\43\75\97\101\75\54\43\99\109\107\53\109\106\83\69\85\74\53\48\116\107\56\74\66\84\53\117\72\75\108\81\84\111\109\116\86\75\90\74\77\79\86\122\72\100\78\115\55\110\114\110\56\101\83\99\53\52\85\75\112\115\43\106\107\55\47\51\113\110\65\67\112\117\73\107\114\55\66\116\107\65\104\90\103\52\114\51\71\87\105\51\108\121\76\122\115\82\83\48\107\117\101\51\101\57\79\111\111\74\50\98\99\89\79\116\118\77\109\120\55\98\121\115\102\98\107\100\89\118\119\84\120\51\73\48\107\66\88\87\101\75\122\89\50\115\113\57\84\102\49\57\111\57\119\112\68\76\121\57\103\89\54\121\112\115\114\71\116\76\49\43\49\70\90\69\86\97\109\49\107\51\82\51\84\108\105\74\70\80\116\115\76\53\55\78\74\53\53\108\84\50\72\75\113\97\88\48\117\75\68\118\116\103\66\72\67\54\69\56\87\107\65\54\122\76\67\102\74\65\104\71\47\119\55\113\83\90\119\70\116\65\78\105\118\52\117\43\78\48\89\69\55\68\72\122\77\100\55\112\112\51\97\66\78\72\79\102\77\49\79\51\107\98\89\57\117\43\85\117\49\122\47\108\50\43\118\107\87\113\51\53\100\55\81\90\71\77\86\75\81\81\80\57\72\47\73\48\115\48\68\107\78\76\70\99\102\117\76\78\47\119\55\118\71\50\111\52\77\98\97\47\75\71\99\74\89\53\86\114\56\98\122\103\105\99\90\55\111\89\113\51\84\48\81\82\86\112\47\86\51\104\83\113\111\104\122\119\110\71\82\72\51\69\114\65\98\56\57\119\54\77\86\78\97\102\53\122\69\118\66\118\114\107\83\110\111\72\77\56\67\52\109\66\99\106\65\111\87\86\108\52\65\98\43\49\105\88\51\71\73\106\57\84\103\52\47\106\51\48\86\87\112\67\74\119\49\67\85\114\75\50\86\101\71\68\69\71\78\111\84\55\83\85\119\49\119\110\109\99\90\78\52\113\67\101\70\49\116\103\82\98\99\119\122\72\108\77\101\82\73\71\50\48\65\68\52\56\51\100\50\83\53\57\99\84\108\57\113\122\107\78\117\69\57\67\49\76\99\106\115\84\106\57\121\82\68\103\57\118\118\71\71\70\55\53\105\83\82\51\103\110\112\71\97\48\77\47\47\122\121\89\54\85\113\85\47\80\79\119\113\98\43\120\68\49\97\72\88\85\66\117\85\75\56\79\115\120\88\82\77\122\76\113\83\108\114\76\66\66\53\104\110\79\66\113\43\81\77\52\72\111\43\77\66\66\103\77\113\48\78\109\81\100\120\52\47\110\67\75\51\108\84\119\98\47\75\51\114\102\105\101\67\98\84\43\84\89\83\43\90\117\116\121\103\48\66\49\98\84\66\51\103\108\55\90\90\67\73\79\98\73\50\84\67\111\88\57\81\78\73\81\117\83\81\54\82\118\103\43\77\98\75\57\56\120\104\83\83\65\90\65\115\100\122\85\107\110\81\113\65\69\121\75\102\77\73\51\81\119\97\116\57\53\77\88\82\68\88\55\110\75\86\103\74\78\73\119\65\99\57\76\115\82\69\104\83\109\103\52\50\103\55\50\47\52\118\112\101\56\115\69\48\53\118\113\49\57\101\51\84\66\108\78\70\80\57\47\53\101\57\86\69\43\65\83\121\108\99\52\53\102\112\105\54\112\107\81\76\83\114\90\98\97\43\117\102\107\76\85\121\52\115\98\57\49\79\109\85\49\43\82\77\112\76\101\71\120\121\53\87\81\105\76\90\101\117\53\67\80\83\116\84\69\113\106\115\52\65\73\107\114\122\85\79\85\81\103\117\50\103\77\74\120\57\117\122\100\119\49\113\82\78\50\54\112\121\118\88\88\88\68\78\56\122\52\104\47\103\103\118\57\66\77\87\68\120\102\56\51\43\54\120\104\90\53\51\67\105\77\109\113\109\121\50\48\107\116\117\105\76\57\101\117\43\103\50\53\88\52\73\83\83\82\87\90\80\106\73\80\90\115\118\48\101\88\55\97\105\75\114\54\112\72\88\112\65\104\97\112\113\68\55\55\113\117\111\85\87\51\65\69\105\105\107\99\75\85\108\51\72\69\67\66\114\52\66\88\106\109\52\113\67\106\57\76\54\67\103\98\71\82\82\115\104\55\88\51\73\101\68\70\47\117\66\119\89\57\74\78\86\116\66\72\43\87\98\52\101\112\43\90\66\119\122\56\73\43\113\105\98\101\90\102\103\114\56\83\54\86\112\89\51\120\111\115\105\109\55\49\122\90\103\114\119\74\69\66\98\111\73\54\89\115\112\113\65\115\90\103\119\71\89\71\100\53\105\89\122\81\85\114\101\110\54\73\75\50\100\81\53\85\87\51\66\74\111\110\82\68\117\70\82\100\110\107\121\103\69\113\113\116\112\113\103\90\112\67\68\76\117\118\82\50\104\100\122\85\52\67\57\57\78\97\51\97\97\81\51\57\87\88\48\98\66\74\110\117\112\109\79\122\81\52\97\69\86\49\70\97\102\50\43\120\79\104\99\50\43\74\107\97\57\54\101\73\68\75\65\70\47\119\85\106\116\48\70\99\118\97\112\97\121\52\53\116\50\120\108\52\72\71\54\101\70\68\102\78\70\53\54\65\122\117\47\49\105\65\47\120\65\75\87\119\84\120\82\117\110\121\99\117\119\120\107\97\113\81\97\108\56\113\47\48\97\122\117\97\110\86\106\79\81\89\109\74\80\111\87\72\52\101\81\90\113\65\99\102\56\53\114\76\107\51\76\69\118\87\112\114\80\53\66\53\51\78\104\113\121\99\87\99\70\57\87\74\102\79\54\111\54\97\121\115\54\117\67\83\47\73\68\101\75\121\88\81\110\83\66\84\99\76\87\55\81\83\119\109\54\98\99\48\76\107\88\117\55\68\121\87\55\50\54\84\52\72\104\113\88\73\119\49\71\49\107\82\112\85\110\112\116\55\70\48\48\122\119\56\65\104\53\89\49\85\105\81\57\115\66\115\43\66\98\100\114\121\112\65\120\87\76\112\99\105\88\90\111\85\115\49\54\71\120\85\47\112\104\113\75\70\116\56\97\82\54\109\108\80\86\57\79\49\107\114\87\77\102\111\108\75\99\49\116\112\50\98\122\114\76\89\49\74\99\55\84\122\74\47\122\67\88\121\54\71\78\88\79\81\85\80\107\85\74\102\81\84\122\122\111\51\90\101\68\71\65\49\114\51\78\43\107\80\80\66\114\122\112\90\107\81\107\56\55\103\80\115\67\85\104\86\112\97\121\100\47\102\76\108\114\71\97\69\66\110\103\67\108\111\104\109\122\82\78\76\119\116\112\88\109\120\100\105\49\43\54\113\75\116\50\43\50\86\113\81\54\51\122\105\56\75\51\54\116\77\85\78\122\56\86\79\121\104\76\53\73\104\66\78\99\118\97\116\117\120\83\112\109\43\101\101\114\43\115\106\120\48\78\86\65\115\110\115\112\68\107\67\105\49\120\74\80\101\102\113\105\119\115\53\52\122\71\114\83\55\100\83\87\55\65\117\51\69\109\83\49\106\43\51\84\107\49\66\82\117\80\119\108\107\104\106\68\90\50\68\82\100\110\106\100\53\86\69\66\76\114\51\80\50\74\49\47\119\73\51\81\84\104\72\72\74\48\66\66\111\73\56\116\115\110\116\101\108\97\67\79\57\113\112\105\88\119\121\48\107\89\112\77\72\79\99\82\66\98\76\80\98\80\120\110\98\43\65\83\120\119\121\84\78\104\97\70\67\114\73\98\85\56\55\67\89\77\97\102\103\43\66\66\115\50\106\89\98\87\107\48\122\48\72\73\120\85\55\89\78\53\102\103\101\53\114\100\43\53\68\51\86\108\112\76\103\84\99\111\47\57\77\111\90\80\68\56\87\53\100\43\67\109\79\43\73\106\106\65\74\88\118\111\82\97\57\107\82\113\67\75\98\90\107\105\83\111\70\118\122\52\107\86\51\52\100\43\121\78\48\74\50\116\113\97\51\78\52\118\119\118\119\71\65\98\118\114\101\84\100\75\52\55\83\50\83\83\118\122\118\55\98\103\120\66\99\110\120\105\102\121\65\53\49\43\55\114\55\109\119\112\66\71\72\117\71\52\79\104\83\89\120\50\54\69\78\53\87\76\51\87\116\70\120\51\70\66\117\78\113\53\89\107\69\86\48\109\53\55\49\85\50\122\65\98\52\49\55\57\54\50\103\73\106\66\83\113\120\72\48\102\72\99\49\73\77\102\73\50\109\101\72\69\115\107\69\113\66\66\79\65\73\101\74\53\50\83\108\115\74\43\107\75\69\56\118\99\56\115\65\113\65\108\70\77\112\85\55\118\110\72\119\115\75\108\100\117\111\104\74\56\89\107\116\88\50\80\86\70\105\101\87\76\105\53\73\73\111\113\97\88\66\66\72\105\115\79\85\68\103\104\48\109\72\107\111\48\66\49\120\106\114\79\82\50\111\106\50\86\66\72\103\57\48\48\53\79\118\111\43\80\57\70\90\111\78\112\87\43\80\100\80\69\102\66\73\97\116\99\103\80\115\43\52\118\50\99\57\83\50\107\85\73\77\50\107\77\102\54\117\65\77\109\49\85\119\77\71\122\115\114\85\116\88\107\102\71\117\55\105\71\71\72\53\68\54\87\79\119\56\111\71\117\81\98\69\51\122\120\43\114\118\113\67\87\107\83\52\87\51\56\106\111\72\56\56\108\47\118\107\70\120\85\68\47\79\108\90\111\107\103\82\119\48\79\77\114\68\115\99\117\82\65\68\49\73\52\53\65\84\119\104\80\88\106\52\65\103\49\89\113\57\106\120\55\70\114\75\102\115\87\52\53\75\49\88\122\99\115\115\68\119\67\101\122\98\90\105\89\98\109\121\48\52\69\73\56\78\109\87\98\99\106\51\49\105\115\88\72\49\53\83\107\67\118\72\108\56\78\48\76\66\121\76\107\73\75\97\101\68\69\102\88\103\109\76\43\70\85\55\53\105\74\105\76\88\52\68\80\56\81\66\98\76\117\67\83\113\98\74\116\70\117\54\48\69\71\73\55\71\115\52\52\65\70\77\110\101\122\115\83\82\114\77\112\57\120\110\97\82\70\65\99\84\78\115\73\50\97\102\43\78\54\116\118\112\112\99\79\51\79\75\84\88\101\102\49\79\109\87\69\55\48\122\118\53\111\101\83\110\83\69\80\90\87\83\51\113\90\85\98\100\108\77\116\66\68\99\75\56\102\83\101\101\107\55\67\84\106\78\103\81\103\122\54\81\85\69\74\43\115\74\52\52\120\104\55\55\56\70\66\52\48\84\72\113\120\118\117\72\88\83\111\49\117\72\50\111\74\110\90\98\122\68\76\74\101\113\71\49\106\119\70\105\114\87\70\71\120\72\78\117\88\85\52\51\71\86\89\109\48\121\86\49\107\68\116\65\72\76\97\110\72\70\113\68\102\122\107\70\122\117\72\118\52\83\87\66\114\107\87\65\87\57\54\110\70\69\67\82\84\87\106\110\111\77\104\107\82\84\109\55\79\49\73\122\81\113\76\77\87\65\112\117\105\102\78\53\113\70\70\79\82\66\114\98\48\99\76\54\83\86\87\68\79\88\69\74\80\73\82\52\102\112\73\77\107\80\103\119\99\119\119\51\75\75\87\121\73\113\102\89\100\99\69\99\117\98\49\70\51\66\104\73\102\55\81\55\54\50\100\55\47\90\77\97\77\110\98\117\103\107\122\101\98\100\100\52\80\119\84\48\107\104\112\119\90\48\115\85\57\53\118\55\83\73\81\50\101\100\89\73\73\52\78\52\89\105\87\87\66\76\47\71\106\99\56\88\103\54\101\103\110\48\52\77\105\87\109\75\81\107\89\110\57\67\83\102\118\98\87\88\84\82\104\101\99\57\116\116\104\70\68\80\106\85\110\113\99\110\117\77\112\99\112\73\52\100\100\88\43\57\103\99\82\84\50\48\47\79\106\108\56\119\71\115\50\70\116\88\111\83\48\48\103\104\73\116\113\78\69\122\102\121\110\52\75\65\88\73\102\112\51\118\85\50\56\43\79\88\104\103\103\76\65\113\56\112\119\104\65\48\43\47\101\72\49\72\66\121\120\101\121\74\72\99\97\47\72\104\102\87\105\51\101\52\115\75\82\103\48\85\53\113\86\103\120\77\84\105\82\113\77\82\74\118\79\88\107\52\68\43\103\77\51\103\73\90\76\87\118\72\110\104\90\66\88\120\119\115\70\71\120\120\100\66\117\67\99\109\79\115\115\119\101\117\106\74\72\79\73\87\85\69\51\117\101\79\107\56\48\70\105\68\113\111\97\103\77\85\73\86\118\110\72\80\52\104\86\86\66\77\43\116\102\72\56\75\49\102\114\77\88\49\109\120\51\99\74\114\49\107\66\111\75\107\55\66\83\119\54\54\50\68\97\90\111\120\76\87\67\89\119\85\85\76\86\98\107\85\122\81\101\89\117\88\50\53\73\86\47\86\52\57\66\116\122\70\75\74\86\74\84\87\67\106\113\108\97\102\102\54\118\87\121\101\107\97\107\104\43\54\47\106\50\108\47\88\52\118\103\67\69\68\122\83\115\99\122\48\49\43\50\118\69\111\81\90\67\78\122\87\80\89\122\99\112\74\100\71\99\115\116\102\113\73\73\52\50\48\66\76\67\80\99\121\112\99\103\49\98\68\116\53\54\55\109\68\49\77\53\72\73\110\68\83\108\118\112\120\55\57\114\108\102\53\83\104\75\100\117\122\114\80\103\48\98\73\106\71\120\112\122\88\81\67\110\71\70\104\82\109\43\105\90\57\109\98\89\73\71\73\80\76\68\121\114\51\72\52\75\85\112\114\117\75\89\112\72\122\76\89\120\87\70\80\109\71\79\104\97\118\122\65\55\70\81\105\97\86\108\54\116\106\113\111\111\53\56\71\86\113\74\70\104\108\56\109\100\65\109\90\110\68\122\87\118\81\98\80\87\112\49\76\120\66\68\66\107\82\81\81\70\120\52\87\115\74\89\109\82\68\74\67\110\67\111\121\69\98\47\69\115\81\82\102\50\101\111\86\77\49\83\122\87\105\99\70\75\108\90\76\78\66\112\75\97\104\52\66\80\48\122\104\71\69\106\105\115\70\122\107\100\77\103\117\85\73\73\104\119\117\53\86\116\114\80\100\69\76\88\43\89\53\79\115\88\69\112\116\102\77\69\83\86\88\90\100\48\47\89\71\105\56\69\84\108\97\78\52\68\49\104\110\68\85\52\55\117\121\103\104\118\109\122\101\108\54\51\110\73\71\76\115\102\80\120\106\73\103\118\102\77\100\117\47\108\114\83\68\66\76\74\80\67\55\116\73\107\97\98\71\88\99\90\111\85\116\122\113\75\54\83\78\86\52\100\73\77\101\50\121\120\106\90\100\65\88\53\105\121\99\119\119\88\71\104\69\76\107\86\86\66\86\119\77\89\121\112\43\106\97\75\65\119\117\77\114\122\51\77\82\108\122\85\103\115\70\86\106\113\77\81\102\55\65\83\80\74\54\99\108\102\78\122\105\78\99\48\72\71\102\112\74\88\43\51\105\112\97\82\111\89\107\107\107\83\118\76\122\53\53\121\105\55\113\114\105\85\115\49\79\74\47\107\119\68\87\97\78\106\72\112\80\81\102\107\47\107\76\76\105\104\122\49\120\85\85\102\88\97\120\114\67\86\120\105\98\104\119\97\73\97\50\47\120\43\103\121\49\84\49\100\47\56\53\56\51\110\108\122\69\116\97\103\43\104\100\113\85\49\84\85\47\83\100\72\105\73\112\75\70\120\122\81\77\85\118\79\69\113\103\112\65\85\82\81\69\101\43\75\122\85\75\120\112\101\106\116\90\105\82\75\43\114\90\77\82\86\106\74\117\82\110\80\110\85\53\107\107\65\84\120\122\106\110\83\107\87\52\48\88\54\78\83\113\90\66\121\88\102\43\110\115\100\107\82\71\49\121\71\56\70\69\87\53\78\69\75\69\102\102\76\101\85\55\119\79\82\110\104\85\101\69\65\74\88\85\82\84\73\88\106\55\56\53\69\54\108\71\111\82\77\83\112\90\48\51\75\51\51\47\50\107\99\101\78\48\73\87\117\105\71\105\111\74\54\83\70\56\109\83\68\81\69\89\111\72\113\116\77\83\72\103\118\88\47\72\99\117\57\76\70\115\51\101\75\76\86\48\109\78\54\82\71\109\103\80\98\75\56\104\53\112\68\43\79\122\86\57\66\43\112\115\70\54\121\81\69\99\99\104\112\118\82\75\57\114\47\104\110\106\65\75\54\112\47\86\81\73\49\112\75\49\50\105\50\112\121\53\114\78\110\118\78\90\67\119\54\70\106\53\122\73\53\114\90\74\47\115\73\116\48\111\89\68\110\73\72\56\81\48\118\76\117\57\65\80\82\70\118\69\88\108\101\53\47\48\47\50\73\83\85\106\117\47\116\77\102\99\102\116\78\83\43\74\103\116\117\116\109\71\65\105\104\49\120\99\48\74\100\48\84\110\120\114\112\47\74\74\77\67\104\84\103\120\66\111\49\108\100\80\98\86\89\66\49\54\80\106\119\98\105\69\54\43\98\116\99\51\47\97\110\54\77\75\108\67\54\116\82\117\75\119\76\48\85\73\105\71\76\88\120\66\75\43\68\72\98\102\66\69\111\85\49\89\122\66\67\105\65\68\47\78\56\66\122\72\115\117\48\106\111\82\49\101\99\50\89\66\75\104\89\47\70\106\85\85\74\110\111\55\113\109\82\53\88\75\88\103\72\83\47\108\98\84\54\54\65\78\103\47\49\79\72\83\77\121\107\48\106\104\84\100\114\113\65\70\65\50\81\101\56\118\82\82\83\106\88\66\69\102\84\82\83\102\85\68\49\108\90\110\67\110\102\68\117\69\114\98\72\97\56\103\68\48\117\71\76\109\119\107\54\103\88\121\120\118\110\84\87\79\106\89\77\121\74\43\53\103\108\71\81\109\87\70\73\49\65\98\99\71\119\87\72\117\89\49\98\79\68\120\85\97\57\90\108\57\54\118\82\69\74\82\83\88\111\79\117\67\81\107\70\82\106\88\67\118\47\117\67\90\120\88\50\56\110\88\82\43\113\80\52\70\89\115\70\112\48\73\115\89\86\87\101\102\47\66\54\82\48\99\56\107\84\109\103\70\114\54\86\105\103\68\66\82\86\88\70\81\71\107\57\113\54\108\111\78\56\100\87\100\72\68\49\71\102\104\66\121\85\74\109\51\57\101\56\117\79\51\54\78\73\109\75\101\54\118\54\79\80\89\79\43\111\118\54\118\116\76\79\119\120\47\67\89\47\116\101\90\47\70\121\108\51\67\72\51\107\78\117\97\90\83\90\68\80\79\120\115\102\84\98\107\65\114\117\47\52\97\104\84\56\85\110\105\73\73\78\89\49\47\52\113\120\67\108\110\85\105\122\81\48\52\86\111\71\49\86\84\75\108\53\98\67\47\117\48\79\79\49\85\118\111\82\99\115\65\113\56\66\90\87\65\90\47\116\107\116\100\78\86\82\108\120\49\54\118\81\85\70\115\103\86\88\50\53\53\120\86\82\79\78\54\103\71\108\49\97\69\69\53\50\79\48\105\55\77\119\55\82\72\47\118\71\50\84\105\102\104\53\65\83\121\75\97\72\43\55\81\81\122\72\76\87\54\65\75\109\111\53\72\85\51\87\119\101\118\112\108\66\72\48\79\81\84\119\101\74\77\97\71\89\122\77\56\118\71\110\107\47\68\48\68\68\81\56\56\73\85\108\82\43\89\87\49\99\111\48\110\108\51\87\48\113\120\72\85\75\116\68\83\106\70\122\53\82\97\48\102\99\87\67\81\100\51\105\77\54\48\74\118\78\108\77\69\121\72\69\53\51\89\80\114\86\69\115\78\67\107\89\50\79\90\86\73\83\97\109\53\79\75\70\81\43\122\122\99\73\113\102\70\53\120\65\52\105\100\56\102\82\74\82\98\104\68\49\86\85\110\80\101\68\109\86\47\51\105\52\122\115\76\87\89\101\55\67\47\49\119\120\106\90\121\89\120\83\81\53\88\56\112\120\119\66\120\108\57\47\115\74\84\84\55\78\85\88\57\81\109\68\43\75\80\81\82\48\79\104\118\88\84\79\97\108\87\47\99\118\105\112\82\52\86\102\70\52\48\89\90\102\72\119\73\119\110\74\47\103\50\67\57\66\53\71\57\79\84\69\98\113\106\49\85\99\72\98\100\108\55\120\111\108\100\102\56\68\70\65\67\73\85\78\66\108\104\108\111\53\101\98\90\115\80\85\56\118\106\80\47\81\88\70\80\98\76\49\98\80\113\108\73\54\70\79\71\86\80\107\53\107\85\113\68\54\87\65\56\51\83\116\77\73\74\55\115\88\68\90\71\71\66\103\114\79\100\104\51\78\57\103\66\114\115\106\104\75\108\116\116\110\106\56\88\102\57\75\52\85\100\77\80\57\108\88\52\77\84\52\99\89\68\51\90\116\71\115\108\47\56\48\79\67\89\82\56\80\115\90\70\69\113\90\98\69\48\69\106\74\52\72\108\119\104\77\68\110\90\47\106\97\107\106\101\90\105\98\89\54\78\101\73\67\102\101\57\53\100\117\118\89\57\74\87\49\69\57\103\120\90\68\111\54\54\90\81\57\49\80\115\106\120\84\122\88\101\75\122\49\81\82\90\113\97\75\86\109\67\77\83\88\79\119\55\117\119\86\101\80\118\116\77\88\66\107\80\66\85\99\116\87\103\71\114\122\122\99\48\76\81\97\75\73\112\81\50\119\51\81\43\118\103\90\66\101\103\73\97\110\102\73\81\122\77\57\77\115\79\79\86\115\98\114\109\90\43\70\88\97\120\112\80\50\100\49\110\55\113\113\108\120\53\76\102\54\80\111\102\107\122\105\98\74\47\70\112\89\110\107\43\118\67\112\90\86\68\66\48\43\112\97\84\118\57\54\74\99\109\109\113\79\43\121\116\117\104\69\106\116\57\52\54\51\85\121\57\98\90\54\83\111\120\71\84\50\69\88\69\89\112\111\52\57\43\48\73\109\111\120\50\84\54\65\72\74\67\50\47\107\100\98\54\113\121\117\47\80\108\109\120\108\80\50\69\81\97\56\120\79\75\117\73\85\104\72\66\80\87\100\82\50\50\54\99\70\77\104\111\77\99\84\77\98\78\111\98\66\57\78\54\100\68\101\55\76\101\85\121\69\79\106\80\66\116\72\54\113\54\102\119\88\81\98\43\84\87\70\113\115\53\79\50\55\51\57\52\122\74\52\113\112\65\71\88\81\118\114\106\71\114\85\102\101\71\107\75\68\112\118\79\110\68\106\114\82\54\88\122\71\107\81\103\101\56\117\86\57\54\111\107\117\71\65\50\68\122\80\121\50\114\113\78\113\89\115\120\103\78\118\98\111\121\98\120\65\82\117\84\78\48\120\80\88\101\81\121\97\68\100\116\104\102\77\78\120\114\103\114\55\121\102\49\50\82\73\117\97\67\97\57\57\101\105\79\120\68\76\72\87\113\56\85\109\109\55\77\54\74\102\70\117\102\54\103\53\50\69\118\87\99\68\80\122\87\50\86\79\85\79\48\69\77\100\108\82\66\71\65\98\69\86\83\65\81\85\66\84\111\80\81\71\97\99\83\117\85\69\118\80\98\122\83\73\53\69\49\76\67\114\66\103\110\75\97\109\77\68\97\117\113\79\86\104\69\122\84\118\86\120\54\71\118\119\114\70\109\84\47\67\73\105\88\79\76\101\53\121\109\79\49\86\115\71\112\79\100\73\51\114\100\99\112\107\43\70\102\54\78\113\112\50\119\99\107\115\76\75\115\51\102\52\76\99\75\71\116\85\89\71\43\119\78\73\97\55\55\66\65\70\97\73\65\118\82\55\100\119\57\74\54\108\97\78\53\67\112\72\121\100\101\105\55\119\103\107\66\48\118\53\52\79\113\103\50\113\98\51\53\87\52\89\80\68\112\66\109\106\112\113\112\121\73\51\50\72\109\113\120\67\101\103\88\68\71\47\50\84\77\87\110\51\88\99\71\100\87\43\74\114\103\110\115\115\116\108\80\43\85\109\87\72\103\90\87\81\101\120\89\67\50\66\54\106\48\85\52\114\97\70\78\80\115\116\89\114\88\55\72\104\48\115\66\111\50\68\112\113\70\120\73\43\107\122\74\100\120\66\90\48\75\114\120\111\55\57\84\122\81\70\108\110\67\118\86\48\117\74\54\97\67\75\43\112\120\87\43\65\81\79\75\71\84\80\65\88\102\118\66\57\72\86\74\80\116\49\106\98\65\100\116\89\111\54\99\84\57\108\103\103\88\116\86\105\73\100\72\113\51\113\71\109\97\121\113\104\86\121\116\67\51\117\80\85\51\119\108\89\80\111\54\69\104\48\75\102\116\98\69\102\71\78\53\122\49\114\110\81\48\86\107\100\122\90\110\108\79\69\86\105\51\65\103\113\90\48\71\115\85\109\104\78\66\53\104\75\120\90\88\117\107\51\112\115\76\75\85\84\66\88\110\102\81\48\47\119\105\90\87\120\100\53\85\82\53\55\110\103\67\56\85\56\116\111\110\98\55\86\56\108\79\103\73\108\50\71\43\78\74\105\106\84\114\111\108\120\99\105\84\113\110\51\110\100\81\65\48\85\86\85\72\71\52\99\43\49\68\43\104\77\57\102\84\110\55\49\77\115\83\53\54\82\79\102\48\82\118\68\114\99\106\102\74\112\80\77\87\115\78\50\112\52\77\74\121\75\51\121\88\76\87\120\57\89\105\106\109\70\68\111\110\66\74\106\67\110\90\90\116\101\89\50\88\52\110\50\48\98\57\78\114\66\107\71\69\68\103\122\107\110\57\75\82\84\106\88\88\65\99\107\85\90\51\79\81\52\77\109\116\89\80\76\48\49\122\54\114\81\81\78\102\100\88\65\107\47\112\76\73\98\120\72\48\109\105\105\113\78\105\111\89\78\106\47\56\52\104\103\65\117\118\69\69\116\81\49\98\51\111\110\57\71\90\49\106\111\78\75\76\109\110\114\66\65\70\97\122\70\103\104\75\79\90\122\111\56\55\57\52\71\50\102\112\47\97\85\115\54\51\67\110\110\85\111\65\49\50\107\67\47\105\86\49\57\73\90\109\104\88\116\74\85\100\105\43\53\48\84\113\117\86\74\52\43\90\80\87\99\122\118\52\84\81\69\101\90\67\109\113\54\79\53\69\100\100\54\76\114\52\67\111\75\71\43\83\43\74\87\69\69\98\122\121\72\81\57\73\74\101\81\118\105\83\80\117\97\49\103\101\66\86\55\86\70\109\48\90\70\49\111\75\112\84\75\119\80\53\69\114\65\66\101\65\116\57\121\54\82\100\74\53\75\86\48\47\65\80\65\121\110\90\53\84\111\111\52\106\113\98\113\52\99\103\66\82\88\53\81\48\101\109\68\111\122\67\103\115\86\53\50\83\83\87\69\78\66\66\111\48\106\51\97\48\74\83\110\86\87\68\66\85\118\120\70\99\74\112\66\83\119\65\104\75\112\66\43\55\85\101\53\53\104\56\48\105\73\78\110\57\67\84\109\113\98\82\105\97\89\75\52\85\105\65\109\69\49\106\52\112\51\117\122\107\48\81\82\117\81\90\80\100\70\116\67\43\48\81\111\87\57\72\101\79\110\51\86\89\104\87\67\111\85\98\81\88\65\112\83\104\51\112\107\79\72\43\56\99\50\122\111\56\99\122\122\105\66\43\56\71\102\72\83\73\49\100\119\54\110\106\101\114\113\75\100\78\66\66\88\120\107\103\113\112\117\68\72\97\67\117\86\74\84\50\117\49\117\69\85\115\71\111\78\65\78\103\76\118\73\50\113\86\50\102\67\65\75\71\47\115\108\56\83\73\78\76\76\87\112\110\75\117\56\122\100\105\110\69\68\98\111\112\55\88\107\49\97\67\53\67\73\102\107\112\75\117\71\118\53\43\71\51\69\119\56\79\70\108\49\52\106\48\118\56\100\50\77\108\75\49\107\72\88\104\88\113\88\78\51\49\86\102\102\99\98\103\81\84\105\122\72\74\97\82\82\78\87\56\75\88\112\68\71\122\87\43\106\119\67\74\90\115\117\114\86\88\65\68\90\85\79\83\73\107\116\108\51\68\75\109\65\73\108\52\112\106\117\48\112\121\75\120\104\72\102\71\72\52\51\84\50\90\65\56\99\120\104\103\81\112\114\85\70\100\99\88\87\76\80\109\118\72\68\98\81\101\70\76\51\99\107\83\56\82\99\67\85\73\47\119\52\76\51\118\115\88\67\103\104\117\83\68\81\66\81\54\103\103\85\76\87\106\43\101\81\82\120\81\90\100\87\75\57\88\90\122\102\78\120\111\108\98\109\80\43\117\69\55\97\112\85\66\111\97\121\101\56\55\116\101\117\54\77\113\101\51\68\99\79\115\110\86\75\49\83\115\86\110\87\98\69\89\72\119\74\65\57\97\66\47\84\100\76\103\110\101\90\55\75\97\87\57\79\108\99\65\51\98\77\52\80\100\119\75\78\117\51\107\113\119\84\86\113\82\104\54\117\66\100\108\97\89\112\55\81\75\77\106\82\55\47\49\114\67\52\51\83\100\115\115\117\85\56\117\77\104\101\106\47\82\48\85\120\48\49\71\86\86\112\102\111\50\72\70\97\71\100\66\85\47\56\121\111\75\67\50\83\111\53\76\52\114\76\90\48\108\111\54\80\88\48\84\80\50\54\49\89\83\55\101\56\117\109\106\87\109\118\89\76\53\78\88\68\104\78\100\49\51\90\88\111\90\69\97\105\90\86\99\107\97\79\122\84\121\122\53\55\117\52\72\122\43\101\69\66\99\108\86\115\53\115\118\78\87\85\102\97\113\85\77\107\66\116\108\106\83\102\104\53\107\53\70\67\54\73\115\109\112\120\70\49\86\122\48\108\73\72\89\85\106\108\112\67\54\73\119\56\113\51\108\54\70\89\77\83\83\116\77\89\75\65\47\50\118\117\50\75\56\75\73\119\109\103\47\102\47\53\53\114\103\104\89\70\110\88\102\88\118\65\109\113\113\99\105\109\108\108\65\55\83\111\119\47\82\115\117\76\81\120\122\87\73\47\68\70\110\121\74\90\84\105\106\56\98\57\88\80\105\112\84\111\114\104\111\100\118\102\112\73\71\117\112\107\43\109\48\51\119\102\51\82\119\73\83\81\113\73\110\81\119\103\86\56\118\77\120\43\89\90\106\121\88\49\69\118\76\106\47\71\51\98\98\86\73\107\72\120\110\116\105\53\71\84\118\114\104\110\84\115\70\122\85\89\104\48\86\52\115\75\71\85\105\99\102\75\80\90\65\72\100\107\74\97\90\80\80\52\97\89\71\109\47\72\111\68\75\74\89\53\78\85\87\76\71\74\112\108\65\77\57\89\115\87\119\53\107\112\50\85\86\79\67\57\103\50\50\119\111\75\75\83\54\49\119\110\49\121\72\90\81\105\69\98\47\66\117\103\120\80\70\49\102\115\104\121\70\43\112\81\86\99\110\118\77\68\119\73\77\48\115\54\49\50\73\97\76\117\76\110\87\56\102\74\105\113\70\101\103\73\86\108\118\119\49\52\73\105\68\69\67\83\55\111\121\65\50\104\113\49\115\77\54\104\108\76\112\84\122\108\112\72\107\101\84\73\122\69\116\72\114\51\57\72\49\67\110\102\104\50\121\73\81\66\90\112\79\50\110\77\103\71\89\68\101\98\54\57\78\115\108\54\103\75\121\54\67\86\48\108\65\55\72\71\112\55\49\82\100\87\51\112\49\110\100\98\108\48\54\66\82\55\98\75\87\111\74\97\118\106\67\71\49\122\47\86\112\70\54\47\121\71\73\108\83\86\88\113\56\52\52\51\100\84\88\82\65\115\110\55\69\114\70\102\47\116\67\67\79\43\101\90\56\104\103\78\107\105\65\47\115\111\67\72\74\77\109\87\69\109\97\102\119\86\43\67\75\102\103\66\56\51\75\108\74\85\106\81\118\87\119\115\101\88\47\48\43\72\118\99\104\48\78\87\97\65\47\102\104\56\113\53\51\86\72\77\89\47\97\85\65\76\74\122\71\89\82\51\73\87\51\81\87\65\116\49\102\82\121\114\108\97\75\97\71\107\70\103\53\107\81\114\121\97\82\43\107\112\122\122\109\110\83\97\84\112\74\82\76\78\76\66\117\80\102\90\114\47\47\56\118\89\108\87\80\71\119\110\113\113\82\43\51\50\109\106\47\106\54\99\78\120\80\65\52\73\116\47\82\74\68\55\109\109\68\67\122\107\100\121\103\48\114\81\88\81\79\83\74\47\100\66\86\66\54\119\109\106\65\85\87\66\113\48\68\88\72\86\70\80\105\117\108\76\107\110\83\78\119\78\85\57\47\100\101\106\79\114\87\114\98\49\113\70\109\98\115\111\87\65\98\103\90\79\115\78\71\102\81\50\122\54\109\81\79\65\105\99\103\84\83\52\43\120\75\82\54\102\85\47\122\67\99\74\105\119\81\114\43\104\108\88\102\106\70\119\78\105\98\102\80\57\119\107\101\115\56\89\112\111\66\122\79\43\65\65\82\74\87\116\119\90\107\78\66\70\118\57\53\88\73\89\80\108\50\71\57\75\106\84\120\74\55\72\113\118\57\68\71\72\73\80\78\120\55\47\74\105\52\49\99\51\118\75\99\117\53\73\102\113\70\50\51\118\66\113\119\110\106\81\109\104\82\108\66\82\84\97\105\57\66\82\54\106\88\47\54\72\109\85\72\89\56\86\98\47\110\81\121\105\43\66\112\113\111\74\105\57\50\74\51\69\89\112\78\65\98\57\47\98\84\68\49\112\112\90\114\104\109\74\110\74\77\114\69\119\55\47\120\79\90\43\69\79\86\50\84\111\118\102\55\85\73\116\48\115\84\73\65\113\116\114\97\102\87\65\82\75\69\78\47\104\53\73\122\81\122\49\69\88\105\99\70\97\97\80\74\70\99\103\104\100\69\97\50\99\74\47\116\104\108\84\87\120\113\75\106\43\43\73\51\56\51\99\89\71\107\56\87\84\53\110\101\119\75\116\119\85\51\74\74\99\78\100\97\76\106\81\97\109\102\70\84\82\69\73\66\105\114\90\87\79\90\116\47\105\78\100\55\43\76\80\51\48\56\69\90\77\47\67\69\71\52\108\54\114\81\51\76\84\55\107\119\99\52\68\116\65\71\79\69\109\118\55\106\85\66\108\118\75\47\116\86\89\72\108\98\49\77\99\110\105\71\73\82\65\107\98\88\74\52\85\121\109\43\105\99\66\68\51\109\105\113\53\115\68\51\83\117\90\73\111\98\86\68\69\100\121\79\109\98\106\116\97\74\101\88\98\52\86\110\48\109\111\119\97\111\51\89\53\57\121\79\76\67\81\107\89\99\122\89\56\100\73\90\76\99\108\76\120\47\117\52\76\48\83\81\110\115\71\104\76\50\120\81\53\56\55\86\104\84\119\86\85\98\43\57\108\75\53\122\47\122\48\106\78\87\57\86\54\101\99\57\73\121\77\70\83\121\89\103\48\80\53\119\106\47\84\112\65\86\72\88\87\120\85\76\75\67\73\103\65\101\82\105\84\101\87\57\77\121\65\77\103\109\99\116\118\106\77\121\51\109\76\100\74\56\84\76\75\82\69\84\88\86\103\47\43\98\80\80\111\121\75\108\49\76\119\101\54\56\83\71\72\112\68\57\85\47\90\48\72\122\71\78\121\51\103\119\109\83\121\51\52\76\120\75\76\122\109\111\53\79\97\56\108\51\79\88\109\81\55\73\103\66\73\115\113\79\70\98\70\114\66\118\51\80\54\74\72\106\68\115\51\70\47\82\51\112\52\89\76\70\99\90\104\55\100\69\85\107\79\88\54\114\74\68\69\82\107\120\107\107\99\99\117\90\52\86\56\80\79\47\118\103\72\53\54\83\56\87\74\56\66\77\113\87\73\70\90\103\107\78\114\51\65\121\86\109\55\53\88\109\84\51\54\90\118\81\120\89\88\90\53\110\70\55\115\121\121\98\73\71\69\74\68\79\109\122\83\48\120\99\53\105\65\84\77\43\79\120\111\56\54\55\72\115\48\88\69\85\111\114\122\55\105\110\118\109\116\105\72\121\57\87\113\115\100\113\82\89\100\107\97\97\102\103\76\112\103\116\111\115\57\118\67\43\52\55\70\117\78\100\73\52\56\104\50\97\100\99\71\103\53\101\56\49\97\53\70\114\90\73\52\51\97\75\119\43\99\75\87\83\82\88\120\107\81\111\97\119\80\122\107\47\122\53\103\79\115\55\72\88\85\88\112\69\101\81\69\72\110\90\103\84\103\88\101\113\55\98\115\101\89\116\99\88\97\109\76\97\67\53\72\106\75\99\89\97\77\88\116\88\75\74\87\89\101\113\89\79\54\51\115\107\84\113\68\66\87\81\118\115\99\65\108\66\121\111\65\51\106\78\105\85\81\89\50\109\54\50\122\70\85\86\78\104\57\76\108\107\47\69\67\111\88\84\43\111\76\55\88\98\107\90\102\114\115\109\115\79\97\66\51\107\99\81\87\71\111\90\90\102\73\88\121\106\73\109\57\104\55\65\121\112\105\100\80\99\118\83\82\100\56\86\90\114\109\81\78\110\117\90\90\104\85\87\89\65\75\106\87\86\114\67\99\101\111\43\111\89\87\57\101\71\104\75\48\84\115\72\66\98\81\55\72\105\89\72\122\103\121\73\72\57\105\120\53\88\114\55\115\90\85\80\107\106\51\80\75\54\84\97\69\106\114\101\53\80\112\54\66\53\76\101\66\73\84\107\68\101\115\75\113\56\57\55\48\43\90\67\117\106\53\75\110\66\109\105\98\86\51\86\53\122\53\69\68\116\109\48\84\82\114\57\75\69\68\82\116\100\88\97\55\117\81\108\67\107\88\107\100\118\54\114\52\100\47\65\108\53\77\52\113\120\108\68\101\117\78\119\114\120\113\89\82\69\118\86\112\78\43\68\113\82\78\85\118\97\55\113\81\65\50\86\115\53\101\101\51\109\87\87\108\98\110\75\99\82\97\113\43\104\116\122\102\56\48\98\108\121\83\107\108\119\104\113\108\102\54\55\121\112\55\98\107\75\98\107\110\72\50\78\100\80\69\72\106\52\86\68\90\70\116\90\72\98\117\81\69\102\99\121\88\106\73\72\55\78\98\113\108\111\70\70\57\102\79\113\70\119\74\66\72\82\112\104\72\112\88\70\82\103\75\73\79\105\116\83\110\47\122\108\99\111\82\56\107\107\80\50\56\48\65\87\81\43\52\110\48\43\49\117\67\114\49\89\114\88\71\50\85\105\121\82\115\114\75\65\75\79\76\104\107\75\84\114\118\99\77\65\67\106\79\79\112\98\87\70\90\80\52\84\65\50\109\69\53\110\78\74\99\89\75\103\97\88\67\103\90\112\81\121\120\52\88\119\48\116\108\66\113\102\56\84\56\56\53\78\71\90\112\84\75\65\108\100\53\115\77\83\47\65\67\106\108\102\122\110\89\122\65\110\97\82\77\111\77\87\43\85\69\98\86\77\85\103\66\56\97\75\87\74\75\104\118\55\98\79\86\76\117\77\113\49\86\48\49\107\74\109\56\121\122\110\43\77\65\79\83\71\84\100\106\52\77\87\80\56\88\69\49\106\75\122\83\87\107\97\106\113\81\77\119\76\80\86\71\120\117\97\57\110\104\115\75\51\74\56\56\102\69\100\115\57\65\118\71\83\85\101\121\50\54\106\101\50\111\100\56\74\99\71\68\43\109\102\48\101\104\112\77\116\88\106\51\68\108\98\116\87\109\77\104\65\79\48\72\66\55\105\122\104\76\79\82\83\85\108\116\51\108\106\87\112\118\55\65\116\109\73\55\73\100\53\82\90\56\101\104\89\70\117\102\55\112\103\77\54\69\112\84\108\83\89\68\98\55\117\51\90\115\98\80\107\121\75\67\66\88\110\119\72\97\83\71\65\55\114\104\102\99\83\116\66\103\43\109\70\74\76\49\89\47\103\90\50\107\86\78\98\98\111\77\51\105\86\84\71\90\84\102\66\115\108\87\69\122\74\121\85\66\49\102\76\73\73\105\98\112\71\113\112\109\83\72\120\47\101\57\48\49\108\67\43\106\70\111\66\116\119\122\120\51\74\68\79\100\43\114\90\78\76\87\120\101\77\77\48\66\109\71\82\112\122\87\89\120\98\122\102\78\43\68\70\68\86\50\88\113\47\90\87\105\111\116\107\116\81\68\89\85\88\84\103\47\47\49\111\72\87\74\114\112\109\68\47\105\54\86\73\115\71\109\48\120\48\56\115\47\108\120\78\101\81\69\108\51\47\118\78\74\87\71\84\78\85\107\109\43\90\70\67\119\84\89\98\78\83\65\72\68\122\85\101\98\112\87\68\47\103\106\53\81\74\87\55\105\111\106\77\53\49\90\55\109\80\86\76\57\113\97\43\74\51\51\80\101\99\79\83\75\50\79\106\85\107\98\72\78\116\113\75\72\77\81\47\108\100\109\85\75\77\47\115\122\97\67\84\107\99\101\71\101\113\72\55\107\53\84\107\57\119\70\103\101\90\78\112\100\84\56\79\43\71\55\71\57\121\65\51\118\122\88\80\55\53\47\48\104\117\104\70\69\52\114\75\49\109\72\69\89\110\121\114\88\77\105\49\67\81\90\114\109\109\78\77\81\87\69\73\73\76\68\83\67\83\122\51\121\87\65\89\113\121\113\107\109\65\82\108\73\90\76\73\87\89\87\50\73\80\106\71\108\104\55\120\51\115\70\86\78\87\116\108\109\107\80\111\89\119\81\106\49\49\71\84\76\107\79\122\77\81\49\100\104\51\53\71\74\103\54\111\57\114\54\78\102\79\68\68\52\47\73\80\114\113\85\50\115\115\120\68\103\73\79\120\50\72\51\118\68\114\49\72\72\99\80\69\98\107\105\118\69\75\76\107\114\79\81\70\111\121\54\109\70\50\85\80\53\54\106\120\109\106\81\49\82\82\104\75\121\103\90\101\113\71\101\75\116\48\97\52\65\68\53\49\83\89\77\48\73\48\118\74\67\118\57\74\90\51\68\98\50\67\52\102\90\80\54\99\104\109\76\48\51\109\55\107\70\68\101\85\114\102\108\80\56\88\68\74\120\67\48\82\87\87\100\110\77\110\54\49\100\99\115\90\115\102\107\81\72\110\53\112\90\104\110\114\86\114\99\106\70\97\116\65\114\103\52\65\113\49\52\101\100\122\80\88\116\99\47\76\71\70\49\81\83\78\121\49\50\97\81\111\75\119\48\69\115\104\106\112\101\83\88\53\52\97\110\102\52\83\75\47\98\122\75\67\66\118\88\47\53\121\105\68\71\66\114\54\81\75\57\122\79\56\55\87\86\82\53\110\99\56\73\80\104\57\117\70\103\114\52\87\70\53\70\50\74\117\74\87\108\119\74\119\51\74\49\57\66\108\66\100\83\80\89\100\119\57\78\72\81\87\110\119\51\101\43\115\52\73\114\49\109\88\79\80\82\75\70\73\121\48\74\84\71\119\112\66\56\69\109\109\122\48\122\43\84\90\100\110\105\49\76\50\106\82\51\54\97\54\114\68\50\98\114\70\70\48\65\68\101\80\116\81\105\47\52\77\54\75\113\56\50\88\67\57\116\75\106\84\107\49\74\103\86\53\86\51\74\121\122\115\48\56\101\111\114\43\111\120\48\85\54\101\68\89\84\105\77\122\79\105\119\47\99\78\87\106\69\74\69\111\102\87\80\90\113\87\99\84\85\110\50\120\119\77\75\82\110\118\66\99\86\97\69\88\90\114\105\73\78\122\82\101\113\70\79\56\116\52\54\99\43\50\115\99\102\47\49\101\100\110\109\89\109\86\84\101\100\85\78\111\81\105\97\102\120\114\105\110\48\66\108\105\100\83\78\107\109\99\89\78\73\113\49\69\69\116\68\83\70\107\120\105\88\73\82\82\98\120\105\71\102\53\110\56\85\49\119\43\52\47\107\81\82\99\50\65\82\52\66\84\81\70\49\87\65\81\52\89\67\68\109\100\80\116\99\89\48\120\108\98\66\79\83\56\119\57\84\49\99\68\112\89\113\87\102\74\79\74\108\116\81\98\49\98\66\43\76\43\107\72\121\98\73\87\49\80\105\99\43\102\69\81\114\73\102\65\113\49\67\111\81\109\49\112\73\68\103\106\101\109\101\85\75\98\52\105\68\90\68\110\75\121\114\104\119\119\68\102\69\117\112\70\57\49\101\111\113\103\43\112\105\72\79\120\81\69\47\50\116\56\84\69\113\83\55\71\80\54\50\89\106\111\55\43\66\72\47\109\98\88\86\80\83\86\114\121\70\110\84\109\112\55\57\69\68\121\75\75\100\102\76\108\65\49\67\49\87\89\114\48\107\56\111\78\57\104\105\116\104\48\119\107\115\111\51\49\51\90\68\110\70\97\80\74\82\85\83\73\111\56\89\49\84\79\88\97\117\119\107\66\69\81\67\49\116\81\47\108\97\120\106\43\43\101\105\52\105\82\112\53\103\74\68\84\54\122\117\100\57\43\110\78\82\80\88\97\68\83\110\101\85\106\57\97\116\65\54\83\103\104\106\101\89\66\86\77\51\49\65\107\106\119\119\47\98\51\78\88\82\67\76\81\48\79\106\47\74\106\54\54\101\55\49\119\57\119\108\105\52\81\70\100\57\71\112\78\76\88\107\80\85\105\113\101\106\111\114\119\69\122\65\90\83\97\88\102\83\116\112\114\115\89\51\49\109\51\75\75\66\118\114\72\68\75\89\99\77\83\100\50\52\80\43\77\65\108\85\105\105\114\67\115\100\104\67\80\111\53\69\112\49\97\116\118\81\53\112\89\71\80\73\98\121\57\54\110\115\48\69\113\90\66\56\65\67\80\112\72\121\80\57\57\70\88\111\107\47\110\74\43\122\74\67\51\65\79\119\70\66\47\97\81\89\101\116\55\111\112\57\98\100\122\53\100\71\79\110\66\78\72\111\67\117\77\77\107\47\121\65\73\119\69\56\87\70\66\69\105\79\75\86\97\90\53\85\69\78\54\54\72\77\72\86\98\56\103\69\110\109\54\121\111\78\97\67\76\76\117\67\79\55\78\112\81\51\103\89\66\70\54\121\107\79\69\100\120\111\117\71\86\80\97\69\117\54\117\55\56\87\81\99\82\103\85\109\115\85\100\113\48\120\105\102\83\97\119\89\69\43\110\117\71\52\55\70\70\52\81\78\65\79\115\68\108\121\54\122\52\115\50\79\57\102\99\87\52\47\111\83\100\82\80\114\98\110\85\99\120\105\110\78\106\76\77\88\57\55\47\87\77\50\110\87\87\110\103\69\105\87\87\68\81\114\102\106\119\82\65\56\113\67\119\82\101\84\86\81\121\104\122\102\110\87\90\66\77\97\57\56\108\79\48\116\107\82\84\118\51\106\48\81\82\101\118\118\71\90\75\71\107\106\67\107\49\100\108\121\112\51\65\69\98\118\84\102\69\86\98\73\83\117\119\48\116\76\121\106\118\88\47\52\99\115\78\82\76\55\117\53\70\109\73\74\84\100\107\100\71\47\85\49\76\43\116\111\103\83\79\67\73\112\121\111\85\75\97\69\105\114\83\89\77\43\110\75\105\67\67\50\99\79\97\103\86\97\117\51\65\116\69\115\52\73\100\66\122\106\66\118\76\90\86\43\71\122\67\57\55\98\55\43\66\98\72\114\87\48\83\122\110\68\43\118\105\103\112\103\116\111\105\56\100\118\117\53\48\53\54\57\43\50\66\86\81\72\85\47\79\90\97\113\121\102\90\111\51\113\65\117\78\98\114\110\77\90\49\122\55\79\56\86\81\103\109\109\107\69\100\121\107\88\118\114\55\78\90\82\98\110\81\71\98\68\80\53\43\84\50\43\56\68\111\56\85\47\76\90\85\116\76\85\106\77\69\85\78\80\74\106\51\56\81\73\57\105\70\89\113\69\105\68\109\100\113\107\80\111\68\66\117\55\97\99\73\55\47\111\106\111\117\114\121\88\104\111\76\67\97\48\104\66\85\105\112\52\117\70\88\109\102\78\85\101\47\111\74\103\80\49\74\66\84\67\121\118\122\52\51\81\102\52\82\108\115\65\122\116\121\90\52\54\99\108\80\104\79\50\84\116\72\54\83\99\107\82\69\76\75\98\107\99\107\79\121\82\70\72\57\79\77\82\43\78\99\114\74\52\108\54\118\70\66\113\100\116\119\118\51\80\114\68\53\112\74\70\51\80\66\84\66\105\85\81\51\82\85\108\57\108\116\74\54\72\102\79\66\65\90\106\99\111\107\99\66\102\110\54\72\70\57\73\113\53\80\73\54\110\72\101\120\104\71\85\104\75\54\99\52\49\43\51\53\43\118\68\103\53\101\78\106\43\89\52\43\75\120\105\84\122\105\105\119\118\112\105\89\65\110\109\43\73\112\114\47\66\53\101\107\84\81\107\77\68\71\54\75\71\97\47\85\87\76\116\47\120\104\111\75\87\54\84\119\100\77\120\115\120\116\54\98\81\47\110\43\75\79\86\79\73\104\100\70\69\103\68\75\102\100\84\66\52\43\47\114\47\78\97\102\71\106\84\43\67\122\66\57\47\103\65\53\113\112\50\69\103\66\71\49\47\73\116\98\69\87\43\74\112\121\102\114\48\86\106\71\49\102\104\50\79\82\98\115\74\56\76\47\115\50\114\68\82\77\68\73\122\67\68\54\85\69\80\51\112\70\48\74\85\67\80\50\53\79\117\73\83\104\77\86\68\65\68\80\105\97\66\112\53\69\49\114\76\115\56\72\54\122\88\55\73\99\113\89\53\74\49\101\98\80\57\72\77\99\78\67\118\68\117\82\118\97\51\105\80\119\119\113\77\85\79\80\102\83\110\116\100\70\85\78\109\106\70\53\86\122\76\85\77\66\69\89\75\87\73\52\57\112\90\69\106\116\105\98\98\105\48\109\55\50\98\43\79\54\88\73\121\90\99\73\80\117\88\70\121\73\99\97\106\65\68\115\48\109\110\75\83\116\53\100\103\51\110\100\55\101\50\101\67\86\79\50\52\79\118\80\115\110\97\56\102\99\53\101\100\84\79\43\90\50\116\72\69\109\97\77\72\73\76\116\52\53\76\101\52\90\53\82\82\67\114\75\97\43\113\43\120\98\106\102\53\85\99\100\85\110\78\106\77\115\117\97\53\89\107\115\55\118\112\113\119\120\112\80\48\84\76\75\121\108\76\102\122\66\43\104\116\103\100\86\88\82\119\79\67\56\100\88\85\122\118\52\67\122\79\109\75\82\118\54\79\113\90\78\54\54\117\81\66\114\48\84\107\107\120\106\52\65\56\43\49\82\49\56\117\48\116\103\82\99\119\119\110\116\107\85\111\57\55\100\97\48\53\120\111\118\80\78\120\43\103\105\118\47\104\71\102\79\49\107\71\85\81\114\66\108\109\108\47\111\90\105\109\66\84\78\111\70\66\103\97\102\105\120\100\119\74\88\56\104\120\109\120\112\70\52\49\80\100\97\90\48\77\113\97\117\71\114\69\120\119\107\87\122\55\55\100\102\89\89\47\100\110\43\78\117\99\120\116\82\67\80\67\78\47\52\77\109\115\107\107\102\80\103\47\55\108\70\106\56\106\79\75\49\114\113\57\86\71\112\109\56\83\51\111\69\80\89\43\116\122\86\85\48\111\86\77\116\85\120\50\84\114\115\50\72\108\103\67\122\103\43\122\104\97\85\111\98\78\108\99\80\52\99\108\105\48\49\103\86\74\98\101\112\116\57\77\82\83\50\43\50\66\65\85\57\108\72\50\55\90\74\88\76\106\89\53\66\122\115\50\85\113\48\72\49\50\53\107\57\120\85\102\50\67\106\120\112\113\70\97\118\56\80\68\104\107\100\43\122\114\121\116\49\112\88\47\82\70\116\103\68\70\114\120\81\107\66\86\80\57\98\106\49\66\111\105\47\115\85\47\121\120\114\70\114\74\82\73\98\54\81\88\47\111\54\89\49\43\53\82\90\70\65\105\82\69\120\50\108\113\121\97\117\87\88\56\79\78\86\111\51\114\47\112\85\78\75\113\89\81\66\47\98\85\69\83\43\47\81\47\97\113\54\116\88\74\109\86\56\47\118\109\67\75\53\51\90\81\49\84\101\82\109\72\72\108\67\108\89\50\43\99\52\54\106\104\85\72\108\83\82\67\80\57\80\81\121\79\53\80\56\101\49\72\122\102\54\104\109\112\43\112\68\51\74\99\115\49\55\74\72\49\113\52\121\69\120\110\83\72\100\87\90\76\72\74\82\56\54\82\102\65\75\99\81\77\118\65\83\99\80\98\122\103\87\113\100\83\101\50\112\47\84\69\101\82\73\89\54\112\75\82\110\97\55\121\113\104\90\103\89\69\105\84\50\51\98\48\112\54\87\118\75\55\69\67\82\109\98\54\117\65\122\74\119\103\49\114\51\71\118\51\101\118\56\78\112\101\72\100\84\111\118\53\102\53\50\120\109\48\87\119\108\83\108\49\87\110\120\109\77\87\85\66\99\121\76\56\72\86\72\109\66\118\65\88\97\122\51\73\98\110\72\66\90\105\75\43\75\43\83\100\100\90\48\101\88\89\121\77\72\68\117\84\68\84\90\70\66\47\71\74\87\121\74\97\84\107\53\82\82\88\79\83\67\56\111\81\54\81\100\90\69\43\68\80\50\71\110\116\100\107\49\107\105\82\48\57\74\117\90\84\106\71\78\57\80\43\116\87\47\106\107\98\114\56\76\57\102\103\53\85\81\71\70\72\97\70\120\106\52\49\71\97\90\48\67\99\81\77\81\106\86\104\113\43\56\116\89\84\108\112\118\88\110\47\112\48\86\53\71\77\110\108\98\67\120\114\82\74\55\121\112\111\56\104\112\78\90\110\112\117\110\57\86\97\114\47\77\72\86\79\89\111\81\116\85\106\120\90\43\108\122\66\86\51\68\122\76\116\49\118\98\86\80\47\101\109\49\112\66\90\107\100\118\73\89\105\73\72\118\112\72\100\102\70\104\84\120\80\80\51\110\51\103\115\116\48\120\73\80\52\109\121\107\98\104\75\110\54\89\101\89\53\81\89\108\114\115\115\79\113\68\118\88\49\107\108\90\86\112\120\111\84\109\115\109\88\100\115\115\57\105\69\115\83\112\114\81\119\99\79\101\56\88\97\43\115\85\120\87\73\86\79\51\104\108\99\118\55\43\72\78\102\97\119\67\56\52\111\43\100\82\122\104\118\118\49\52\55\90\53\101\110\79\79\86\113\71\75\47\77\113\113\121\54\74\50\115\107\98\102\111\118\67\118\78\77\111\52\65\75\90\51\99\84\101\103\114\78\104\109\113\109\103\105\115\108\104\114\53\119\78\97\97\56\67\57\50\88\82\43\52\49\115\49\100\107\85\108\79\109\100\110\113\99\54\80\70\84\74\72\84\55\49\57\105\111\97\49\53\57\48\55\73\116\106\87\109\117\48\79\76\51\121\85\53\88\75\121\52\108\81\48\56\53\111\65\65\114\43\73\48\81\109\53\73\70\77\101\86\73\89\110\56\79\81\53\79\66\68\105\54\65\48\87\88\51\84\81\77\114\108\54\102\73\81\104\71\116\70\74\78\51\121\72\120\78\116\89\109\54\80\43\53\119\70\82\82\73\98\79\98\79\66\110\68\72\117\56\101\50\72\122\78\90\79\56\67\51\120\65\100\84\50\80\88\80\101\100\71\80\118\65\72\108\83\121\78\80\104\55\106\79\53\104\105\82\120\67\118\121\81\82\101\66\121\90\68\120\112\53\65\113\74\105\116\121\49\99\109\81\54\105\65\85\116\84\110\73\51\75\57\115\113\87\84\66\115\65\43\77\57\87\54\89\68\85\111\118\100\107\106\83\47\108\106\98\107\117\54\65\98\101\83\122\67\79\74\102\47\68\110\118\71\51\71\75\76\74\107\48\99\72\79\86\57\48\84\121\84\97\86\74\72\89\79\101\49\103\113\52\57\69\48\53\55\73\108\109\119\99\111\81\75\79\50\70\87\97\99\115\120\103\118\114\57\102\81\80\113\115\68\72\106\118\67\52\101\71\81\82\47\73\72\56\115\105\57\70\76\87\103\56\111\97\74\72\105\80\105\54\74\77\54\56\108\49\90\79\66\76\55\79\103\82\75\118\71\88\67\85\103\109\48\76\86\113\48\76\108\72\110\66\101\111\118\108\71\113\107\114\85\102\52\109\83\102\86\112\87\56\78\102\77\70\87\51\43\104\54\52\107\71\47\48\112\75\50\83\70\85\85\114\70\114\99\82\81\115\52\56\100\117\85\81\120\56\104\119\81\90\66\79\89\66\112\68\105\67\102\67\85\113\112\51\85\85\114\110\81\100\87\100\55\113\117\108\70\111\67\78\111\88\97\107\113\102\107\116\83\73\75\56\106\50\120\52\72\70\66\120\119\52\83\111\74\97\88\53\73\111\81\86\119\113\85\118\116\114\71\88\82\65\76\67\102\57\118\110\100\97\119\89\43\72\88\116\67\54\111\75\122\70\75\107\105\76\52\76\80\111\100\54\70\48\68\121\53\110\120\48\72\86\85\56\87\110\68\105\71\90\100\113\97\87\89\70\53\108\83\43\114\50\89\107\97\90\100\57\113\89\51\75\84\72\69\88\90\65\69\81\117\98\78\71\106\48\79\103\65\101\119\76\55\75\54\48\71\97\83\100\102\108\79\71\66\47\109\66\84\104\107\100\107\101\120\80\84\112\102\51\49\52\122\111\112\121\114\104\68\56\100\104\74\53\49\49\47\67\109\84\108\99\100\104\48\112\49\114\108\68\48\54\115\65\116\78\55\100\86\54\77\109\69\102\54\85\90\97\112\49\102\77\77\70\99\48\86\119\82\66\99\76\68\56\112\106\88\66\54\66\88\80\74\82\47\119\56\57\117\111\47\85\109\122\76\84\77\73\118\54\115\106\119\103\49\121\83\88\66\69\105\68\73\90\53\66\54\52\70\73\76\47\108\67\71\102\90\53\84\77\67\108\88\66\114\51\122\75\43\47\47\48\115\52\49\78\83\115\66\43\86\82\73\115\55\110\57\86\118\111\108\117\89\111\77\66\84\49\76\103\101\120\88\118\72\105\51\68\115\118\79\105\54\70\90\76\116\80\87\70\88\75\112\56\88\48\70\114\107\112\111\48\81\87\119\50\81\101\49\53\78\121\109\57\83\104\78\74\119\54\77\81\73\103\67\120\57\72\81\68\87\104\76\43\111\56\110\103\90\69\87\112\70\67\100\43\78\54\102\48\109\116\87\118\48\90\100\99\120\55\80\120\115\117\90\113\68\47\89\73\85\111\54\72\56\114\107\120\53\72\110\78\66\104\85\79\52\106\69\89\83\120\80\52\82\52\66\103\110\77\97\110\73\55\113\114\84\73\47\84\43\98\76\79\89\47\68\88\80\65\83\114\53\74\102\80\99\112\121\78\122\120\65\72\116\67\112\74\103\122\72\82\71\89\105\111\75\101\78\107\78\109\107\101\52\108\82\86\71\72\73\86\81\88\97\69\88\103\51\90\72\79\72\84\69\84\66\68\77\112\105\118\97\70\78\115\116\87\66\85\80\102\51\54\69\119\71\121\122\121\74\50\76\66\51\83\98\47\57\72\105\111\54\90\78\79\69\70\47\47\79\104\118\43\97\84\87\106\53\120\48\54\99\88\47\76\80\110\88\69\47\120\108\98\89\79\74\102\48\74\73\68\111\103\53\43\117\78\78\85\67\107\80\112\118\98\118\80\52\76\55\119\84\71\85\119\101\112\111\67\72\71\122\73\120\82\82\97\118\122\119\76\90\49\53\121\53\90\102\90\54\114\68\112\103\98\53\77\90\51\70\57\112\69\79\57\103\49\73\74\50\87\114\87\65\54\88\119\109\122\79\86\50\117\49\71\79\68\83\88\49\111\103\69\50\47\90\101\71\85\114\82\86\112\113\107\71\43\84\75\105\99\107\84\115\69\76\73\56\115\99\112\79\121\116\48\104\80\67\55\83\54\100\85\100\82\86\102\50\80\76\115\84\117\52\98\70\116\82\110\71\109\104\65\47\101\76\56\69\111\86\113\110\103\50\116\74\67\71\65\88\76\71\111\118\65\82\122\85\88\85\74\121\118\87\113\119\57\116\66\83\79\111\65\65\53\84\71\77\71\55\71\114\109\113\87\47\101\66\90\114\108\70\122\57\122\74\117\117\103\88\104\107\70\84\90\79\116\55\79\100\84\57\108\72\65\117\54\67\51\66\70\52\75\47\97\88\66\57\49\67\84\85\90\102\66\114\106\112\120\114\117\79\67\67\103\50\115\78\116\109\76\52\112\116\110\116\116\82\55\122\48\120\114\55\113\72\114\97\117\51\47\70\100\57\48\97\88\119\49\120\53\109\55\110\84\51\74\85\102\65\102\98\114\82\116\87\72\106\117\89\50\88\75\82\100\122\71\99\54\117\122\114\50\89\102\118\100\56\73\53\119\89\76\100\97\90\57\77\103\90\72\52\118\55\49\101\87\43\68\78\67\109\48\79\118\49\100\55\56\54\73\103\110\81\90\75\108\57\87\65\115\70\48\106\84\51\98\108\80\70\100\102\88\74\89\97\104\85\120\112\90\115\47\97\87\50\48\69\72\54\87\48\90\118\114\106\90\81\68\102\103\79\57\101\73\55\78\103\110\90\52\81\72\109\49\81\102\98\111\55\81\50\88\110\117\109\51\43\73\90\80\108\55\72\51\88\55\116\88\52\88\82\100\84\49\81\107\55\74\48\101\109\90\49\73\114\81\102\88\56\74\100\83\81\75\49\84\111\53\52\54\76\109\52\120\90\80\113\90\66\80\116\89\114\101\81\71\84\67\56\66\84\52\85\55\101\55\107\109\79\51\110\98\81\97\110\69\77\107\71\109\114\99\85\50\110\111\72\118\121\54\85\68\70\98\114\73\84\84\80\82\117\74\111\89\85\52\98\99\84\80\101\105\97\113\120\113\118\107\77\87\49\52\54\101\85\47\105\85\43\66\57\71\65\74\49\116\56\89\122\117\103\74\74\87\116\43\43\119\119\82\69\56\89\50\51\53\122\55\86\43\56\101\89\108\115\101\66\111\107\50\109\81\83\51\111\87\88\97\55\118\90\49\101\55\103\80\109\70\69\52\85\116\78\74\80\54\109\47\55\48\114\56\112\115\109\77\108\72\120\74\47\78\111\48\119\118\111\78\51\43\88\78\104\100\70\67\75\106\88\84\66\71\83\80\88\83\74\80\90\98\77\66\51\84\103\105\122\122\81\72\110\104\48\65\116\70\53\98\113\69\79\71\103\114\67\87\88\65\114\74\71\105\77\121\53\50\119\100\76\101\109\121\80\52\101\79\47\113\70\87\85\77\111\72\119\120\111\76\86\122\82\122\71\70\117\87\68\81\66\114\53\53\108\66\107\80\114\115\107\99\111\65\51\109\55\71\106\69\97\70\85\54\72\80\113\69\107\85\98\109\75\71\51\90\43\73\71\115\114\104\82\102\99\68\79\49\113\101\67\88\82\108\52\111\110\72\112\73\43\98\122\77\109\57\111\50\57\90\75\68\47\109\50\114\122\75\99\47\67\53\106\101\71\83\104\65\66\115\111\115\98\67\100\55\90\102\98\112\81\56\102\73\57\114\56\54\75\86\122\65\113\81\122\103\52\79\118\48\73\50\101\107\107\73\56\68\103\102\43\114\101\83\67\77\83\105\73\71\71\56\48\119\75\97\106\56\121\116\72\43\75\103\109\78\103\77\47\119\56\47\53\71\55\83\66\79\104\107\69\68\50\105\75\121\121\80\83\72\74\107\66\50\85\81\103\56\104\97\70\103\43\90\68\113\77\98\109\48\49\54\109\79\49\109\74\99\90\54\117\97\85\81\85\88\69\69\117\77\73\79\89\122\69\121\111\80\83\100\98\119\107\82\76\104\106\103\122\105\109\103\54\89\90\82\48\104\47\102\75\81\73\111\120\98\119\117\87\51\89\105\82\117\102\114\52\76\103\115\43\66\114\76\86\122\118\109\122\76\121\103\48\84\69\107\99\48\81\111\57\122\111\74\121\55\121\47\79\88\97\65\80\108\50\115\118\84\118\53\83\112\106\53\99\98\75\114\83\66\108\113\114\52\121\66\51\84\119\74\117\47\86\114\83\54\114\65\101\66\102\99\83\50\70\66\47\88\48\114\53\82\43\112\109\69\115\79\81\111\67\67\52\110\122\119\90\56\114\104\86\121\110\71\100\73\51\57\48\87\67\76\118\43\75\112\80\112\120\84\69\73\87\74\67\81\108\68\57\43\111\105\78\72\80\75\43\83\82\51\90\105\103\119\110\105\77\102\98\52\70\71\108\54\78\87\108\89\77\104\55\106\114\47\87\79\47\105\97\102\102\54\43\103\98\77\88\102\102\97\82\119\113\118\113\102\76\80\98\104\103\83\72\74\116\120\89\105\89\49\66\55\50\54\99\97\80\99\89\77\97\65\110\76\81\67\120\113\103\97\47\111\66\113\68\52\69\103\50\99\110\81\89\88\71\122\52\100\101\120\55\113\81\75\90\43\114\102\89\49\101\56\71\56\69\72\43\116\67\55\110\73\114\102\84\114\73\111\105\66\69\50\55\86\119\115\105\106\117\84\104\85\72\115\86\103\113\55\105\116\89\79\65\112\65\68\68\108\99\74\68\75\73\117\102\120\119\98\103\56\72\67\65\114\117\87\119\106\103\104\118\122\78\82\120\90\83\118\100\49\90\49\50\79\110\103\104\75\52\76\48\80\48\87\76\50\115\108\73\73\79\68\49\48\99\53\47\109\85\111\119\80\111\122\86\99\121\77\81\65\99\55\88\84\48\109\119\97\48\48\50\56\77\47\98\47\72\100\108\105\86\122\74\70\104\71\101\105\78\50\72\78\88\54\117\48\101\72\53\83\76\84\84\105\76\111\120\115\103\116\80\101\106\52\107\51\78\55\114\116\97\104\82\121\54\83\112\119\70\105\107\97\75\80\53\72\105\110\113\55\71\55\55\66\90\89\111\57\54\72\106\80\81\85\102\90\54\116\119\99\43\75\43\66\89\80\122\83\121\76\79\113\97\81\68\99\122\106\84\105\118\51\74\117\72\81\75\83\49\112\88\102\109\72\116\105\107\86\75\105\109\83\113\86\89\88\69\80\71\82\56\77\47\119\51\104\79\51\47\82\48\69\113\73\48\75\71\107\74\106\56\78\52\109\76\108\120\84\90\89\112\107\86\66\104\86\85\85\80\109\70\57\69\84\118\43\103\74\112\121\110\48\86\121\104\118\106\79\67\99\82\85\74\72\115\114\84\53\119\75\118\102\110\43\83\54\49\100\114\73\67\102\53\75\65\121\74\48\48\43\112\51\98\83\77\54\81\103\55\122\75\84\65\87\81\104\115\50\55\113\51\108\49\101\74\113\122\53\111\77\82\112\118\85\80\43\99\113\109\115\76\118\73\115\120\75\77\75\78\115\112\99\118\72\76\110\97\48\69\75\69\69\122\99\100\99\83\98\122\105\66\122\70\74\106\102\107\55\105\83\53\106\114\107\109\117\53\122\47\110\108\115\67\120\122\57\108\82\69\53\80\120\74\83\52\118\57\101\53\107\101\107\117\88\80\87\72\56\97\74\81\50\72\82\110\70\114\85\55\105\66\51\84\103\90\71\99\76\121\82\101\77\57\112\75\97\90\98\75\67\79\113\122\90\56\90\122\48\76\82\78\111\57\71\79\51\76\108\83\121\97\108\88\82\97\80\116\88\116\116\72\106\115\110\114\88\70\98\73\111\108\66\99\88\101\83\50\84\78\66\75\80\108\89\74\111\104\120\55\56\81\77\102\85\65\121\87\79\121\105\87\84\78\101\107\86\53\82\120\71\70\49\112\52\43\57\114\108\75\112\99\98\77\78\118\87\100\115\66\100\65\89\48\87\69\79\114\47\108\119\78\122\57\76\56\57\53\108\48\98\100\80\67\55\105\54\113\90\56\119\82\105\115\65\76\90\108\100\77\75\75\120\100\86\115\65\89\89\73\103\88\104\97\115\50\73\105\43\65\55\78\88\100\99\68\97\109\54\71\43\68\73\68\89\73\70\90\48\51\73\118\84\71\78\113\84\43\81\117\85\85\113\82\115\105\120\75\86\104\50\89\78\81\66\97\101\119\115\100\77\85\65\78\80\56\116\67\52\54\70\65\100\43\79\117\48\54\108\107\104\119\49\106\79\71\81\50\76\66\76\106\48\71\110\67\71\67\107\117\54\49\97\47\86\100\110\76\122\66\109\113\47\98\68\119\90\54\103\116\105\120\107\119\55\105\74\71\73\74\103\57\89\67\74\116\106\84\118\72\105\70\49\115\102\117\69\87\101\120\69\52\112\70\118\50\65\119\70\86\89\47\66\109\98\47\49\57\82\69\112\87\51\113\54\102\102\117\102\97\99\86\49\69\43\107\86\113\74\86\87\81\69\88\71\104\111\116\43\118\49\120\65\56\67\79\108\114\119\99\48\102\66\98\51\51\122\111\115\69\88\55\89\71\73\71\103\100\111\65\115\68\66\97\50\54\98\65\56\108\56\48\102\49\86\113\118\51\111\47\67\77\107\108\107\118\56\49\71\105\47\116\43\55\66\114\75\114\65\78\98\74\84\87\79\83\53\87\104\71\85\104\80\90\88\97\57\47\90\54\65\103\68\80\112\70\114\98\107\101\50\74\107\87\76\73\108\102\100\54\108\106\77\85\121\70\51\107\86\114\85\54\104\97\77\72\111\98\47\103\78\114\89\89\117\57\55\56\66\103\56\106\66\68\89\111\78\55\100\116\53\48\111\104\116\88\116\68\100\48\90\77\71\86\83\117\118\71\75\77\43\106\81\81\74\57\111\84\48\80\114\85\71\119\68\43\51\72\103\100\49\49\99\49\52\120\57\99\103\68\83\97\77\71\69\122\85\50\84\53\65\120\113\119\57\82\109\89\57\107\66\80\87\84\51\76\113\116\113\85\118\100\112\65\75\53\65\99\90\82\101\54\74\82\71\103\90\107\105\116\88\101\69\67\51\120\117\74\85\83\122\52\69\90\122\50\104\90\86\122\48\85\66\122\118\88\100\72\107\115\85\118\79\90\97\79\120\107\55\49\105\54\97\67\65\120\79\88\70\120\51\83\114\50\112\65\81\102\52\66\112\51\121\104\113\122\108\82\111\108\79\97\88\87\81\99\85\110\109\103\105\118\49\117\77\84\80\71\100\100\70\103\112\116\116\53\75\97\80\77\67\112\86\69\111\84\87\54\43\70\56\113\90\118\80\117\66\67\72\84\119\117\118\102\80\51\67\80\120\56\104\100\48\68\113\83\78\100\52\118\90\50\107\72\114\53\87\85\107\49\82\121\122\76\101\86\111\114\111\114\118\113\98\103\54\118\119\101\99\122\74\78\54\83\80\106\78\118\74\88\115\50\68\88\71\77\52\50\65\81\106\105\89\99\80\111\87\73\66\74\77\74\48\106\117\109\112\99\101\65\90\57\48\77\122\66\78\54\53\114\110\87\86\52\90\84\82\51\81\114\107\83\87\122\114\76\120\81\115\76\99\71\116\73\101\103\105\118\106\50\117\107\73\110\121\99\115\102\99\76\106\112\53\97\71\49\97\112\117\80\77\101\121\101\69\101\80\67\67\100\106\84\56\115\104\79\78\55\99\83\116\79\109\68\90\103\110\56\56\43\99\85\85\110\66\113\47\104\70\70\66\67\99\70\109\106\117\120\118\47\85\43\84\50\68\68\76\116\119\65\85\47\80\69\78\49\107\103\119\55\117\112\71\57\97\122\75\49\115\121\50\106\54\73\104\48\74\71\100\79\111\75\119\86\120\72\108\118\47\65\88\80\98\51\122\68\80\73\67\121\75\106\72\81\105\57\65\77\48\103\97\54\122\52\116\104\74\106\98\108\116\51\116\114\57\78\70\53\65\100\113\122\49\55\120\77\83\54\79\119\66\114\57\56\72\87\105\71\50\79\100\88\65\89\72\87\86\104\53\73\88\70\121\71\65\75\50\99\56\77\72\115\72\122\65\114\106\102\79\113\49\69\51\73\105\83\68\77\65\51\86\113\118\79\79\99\68\81\85\112\110\79\70\117\65\43\65\122\84\83\78\78\74\87\72\88\57\73\115\87\76\85\82\76\101\83\113\88\117\104\67\48\72\106\73\98\88\122\81\74\54\49\99\88\118\67\75\49\77\101\116\118\109\82\98\88\87\73\111\79\100\98\76\106\55\72\50\119\87\100\67\89\116\47\119\85\98\49\70\105\122\57\87\105\88\120\76\109\70\104\86\53\87\106\106\53\66\114\66\85\52\57\78\69\67\49\97\120\98\108\74\74\74\100\53\51\108\122\103\70\87\100\113\49\86\101\51\68\111\102\122\84\119\114\87\106\109\66\57\43\48\107\105\119\54\97\77\103\52\103\86\121\122\81\107\66\98\49\51\71\98\97\80\79\69\70\121\52\70\66\75\82\71\115\109\89\86\102\107\67\43\66\101\68\105\103\114\111\115\114\76\102\77\112\81\47\109\74\109\73\86\122\56\48\108\111\113\121\43\87\98\116\120\82\74\97\55\101\79\79\71\105\118\48\87\73\47\114\109\68\43\57\83\104\54\66\97\78\82\107\114\115\54\110\117\112\114\113\55\69\74\83\74\77\72\50\89\100\113\114\77\71\43\105\67\84\99\67\52\112\112\99\74\47\110\74\57\47\51\56\97\88\75\87\77\73\66\102\51\121\87\111\57\79\111\115\57\98\84\103\97\110\80\103\78\122\115\53\67\117\111\69\98\65\76\80\51\80\102\73\81\48\111\117\113\75\78\122\77\43\56\97\113\90\69\47\120\90\80\101\111\54\101\67\112\114\70\87\54\87\75\117\73\48\68\72\82\99\119\99\112\104\119\120\89\49\81\109\109\109\111\106\79\77\103\80\54\105\51\116\74\87\109\52\107\49\71\70\57\86\116\98\81\116\90\84\69\80\48\88\55\81\50\83\104\56\72\85\101\48\90\82\104\99\48\107\108\110\119\71\106\99\68\110\98\72\120\116\112\72\117\54\99\104\110\119\85\48\121\116\81\89\48\48\99\48\72\80\73\109\121\75\121\118\74\43\51\47\99\111\71\67\43\88\104\99\101\82\120\109\118\121\120\71\48\90\89\89\97\47\120\49\79\114\87\107\48\43\114\83\69\87\81\99\105\70\89\76\79\74\100\47\55\74\112\102\113\78\89\85\66\67\43\50\102\118\112\54\57\102\108\111\43\73\102\65\89\90\122\114\81\68\80\80\56\78\97\114\70\106\112\71\84\43\54\69\53\77\77\87\120\102\122\69\85\48\101\102\69\83\70\55\73\73\67\70\84\55\71\74\54\108\107\57\103\57\109\53\74\65\43\81\51\104\117\87\74\117\107\57\111\77\83\119\108\73\57\51\118\49\85\57\43\85\106\113\82\118\74\122\107\103\113\67\109\97\116\119\84\119\85\68\83\89\86\52\65\114\120\55\122\117\78\67\52\67\120\82\76\102\77\98\71\90\81\52\77\107\86\115\81\81\66\88\48\71\104\43\75\122\66\100\82\112\71\79\69\67\105\70\66\110\65\84\52\78\118\88\117\90\122\111\80\105\115\70\113\120\85\116\116\51\77\54\97\121\73\73\97\48\89\111\113\104\66\101\89\65\77\65\66\100\114\52\114\88\109\51\56\78\75\43\69\100\90\88\109\78\82\73\51\55\68\120\106\83\56\73\52\122\117\112\54\79\50\115\70\85\107\54\116\106\88\72\49\82\65\108\109\111\115\67\115\103\73\47\77\57\73\109\100\115\87\70\54\117\68\55\73\74\72\99\85\66\105\55\108\85\78\68\90\97\51\51\113\68\75\75\86\87\107\56\80\108\117\122\69\90\47\119\120\116\79\54\119\77\114\73\121\48\65\119\69\108\48\68\112\113\102\79\109\108\110\66\43\53\112\122\117\48\68\105\108\121\74\71\75\48\111\87\48\78\50\83\81\98\116\102\70\112\50\112\99\47\75\85\47\103\56\88\66\106\98\108\71\88\105\72\115\75\57\49\43\104\75\74\86\83\113\65\71\83\43\101\66\65\82\89\106\48\109\85\105\105\81\116\87\73\57\73\81\112\120\111\75\121\102\80\56\108\81\122\50\86\54\115\87\113\108\111\100\109\105\115\57\111\74\113\79\119\103\77\85\102\104\122\106\85\83\87\51\80\72\88\111\110\87\55\103\83\84\77\72\79\43\47\77\78\89\87\104\110\88\78\104\54\108\81\48\87\75\66\106\84\57\53\70\66\82\52\85\67\77\81\98\121\102\117\122\52\116\72\55\100\112\116\43\115\43\56\67\53\74\109\89\101\106\70\68\47\107\102\107\122\109\89\55\119\89\99\108\84\100\122\122\68\69\87\104\89\65\107\84\110\57\69\77\120\111\121\82\90\118\71\52\65\55\75\72\101\85\89\79\111\43\47\105\84\77\112\114\56\50\104\43\57\112\56\43\49\73\111\115\98\101\50\121\89\119\84\114\111\104\121\57\48\98\113\99\68\84\65\100\114\116\84\74\56\81\120\68\50\115\83\119\53\99\73\81\66\109\102\86\122\73\121\53\107\113\65\67\87\110\111\117\55\118\117\74\81\103\76\88\110\65\72\110\104\48\70\109\115\47\49\72\108\116\121\107\74\52\47\56\116\71\68\101\105\67\85\98\82\82\114\107\103\88\69\117\70\109\99\87\43\57\73\99\74\55\118\121\66\99\112\86\43\75\74\71\120\88\81\122\115\70\116\98\86\83\111\49\105\115\107\84\55\85\88\72\90\49\119\80\70\53\75\79\114\110\47\120\98\80\70\101\112\99\75\81\109\87\105\89\106\73\82\111\102\122\66\114\120\116\72\50\97\111\77\88\105\69\90\109\114\88\98\99\65\105\70\120\55\55\76\113\119\105\119\90\53\52\119\81\66\77\90\54\102\101\43\56\88\119\102\80\65\80\106\43\78\119\104\77\50\82\82\71\79\114\118\76\109\83\82\105\107\87\83\73\118\53\73\112\87\52\110\68\113\119\83\55\50\53\70\97\75\79\49\109\83\117\97\101\111\112\66\43\57\107\110\81\111\106\107\110\51\115\108\101\71\116\67\89\74\105\81\89\71\56\113\52\104\43\78\99\78\117\113\49\49\109\71\90\53\54\103\109\113\110\49\66\110\85\120\47\66\119\108\121\100\88\81\103\80\112\68\56\104\82\102\113\78\52\51\68\57\101\102\84\87\56\108\54\115\98\98\73\71\71\55\98\55\69\112\83\78\106\75\80\108\88\87\54\57\104\90\112\50\108\103\71\74\105\48\98\108\83\113\47\90\106\122\104\83\68\105\106\106\82\102\100\115\114\50\108\111\112\112\116\83\114\109\81\98\109\75\67\108\90\69\80\65\90\90\87\50\90\68\117\72\66\67\50\118\56\112\47\51\90\69\43\72\111\117\102\112\83\50\53\88\104\65\47\68\48\101\71\77\112\53\87\102\117\112\113\103\57\52\106\67\112\115\107\114\52\74\48\111\66\97\49\88\87\52\118\54\74\111\120\102\88\86\89\47\77\79\54\47\77\105\114\101\69\47\66\104\81\51\118\103\114\104\73\78\113\105\112\99\108\116\83\102\85\103\68\71\51\56\50\100\90\114\78\118\76\111\80\66\90\90\109\73\80\106\111\68\88\53\117\48\68\108\72\87\109\99\101\111\97\116\90\118\71\48\87\85\117\55\103\121\115\111\108\47\50\121\106\74\52\98\114\47\98\47\104\43\106\87\87\71\116\68\109\84\77\99\77\48\111\107\102\75\122\98\67\102\112\43\117\111\80\120\109\79\53\51\84\78\107\110\53\55\50\109\117\112\109\90\121\98\76\47\72\72\116\108\54\57\76\116\67\78\84\109\75\47\116\113\57\77\84\117\98\76\99\103\66\87\81\115\43\50\77\49\100\108\72\112\48\122\72\80\89\120\117\109\82\54\104\90\84\112\56\69\118\89\120\119\49\98\67\52\77\99\119\115\73\88\111\121\101\80\66\119\76\111\98\114\66\48\108\74\83\52\107\119\112\50\72\81\43\48\80\73\101\117\57\81\113\118\81\72\84\105\71\99\104\112\118\113\85\107\122\110\78\81\69\48\51\68\71\79\117\117\118\76\51\111\72\77\74\65\49\82\88\117\101\88\111\102\118\49\100\114\98\49\76\89\43\52\49\112\56\112\119\83\98\66\83\102\70\79\67\90\74\49\85\110\98\66\88\71\51\73\98\106\117\71\99\112\89\57\83\68\102\118\105\57\102\56\105\71\121\110\50\84\107\53\70\98\81\69\100\102\72\101\100\85\70\83\56\111\122\82\120\98\108\81\50\72\87\51\78\83\81\110\52\80\119\119\101\57\70\110\121\77\81\108\68\79\103\116\122\82\99\81\88\75\53\118\111\68\97\103\57\116\116\55\106\118\120\110\88\90\84\74\112\73\75\85\116\98\47\48\120\120\102\67\106\98\77\54\47\84\75\79\98\111\54\117\89\56\102\107\104\112\49\98\83\49\56\116\82\83\119\70\97\110\56\89\57\52\56\114\109\68\105\115\52\66\56\105\83\73\83\47\77\97\50\120\122\66\102\122\98\67\121\84\100\50\74\118\74\74\103\97\75\114\71\48\109\97\108\47\110\54\49\107\111\43\89\109\104\117\71\70\98\74\84\71\65\114\112\80\103\78\83\76\89\49\74\65\88\85\66\76\117\116\74\117\85\114\121\81\107\105\79\118\99\100\88\99\71\57\84\43\102\113\76\98\107\70\67\101\113\98\72\109\86\52\65\121\66\80\101\79\48\113\67\86\116\106\57\89\100\72\78\69\88\102\107\84\51\77\103\105\119\47\110\89\114\51\100\83\79\104\120\115\76\89\105\99\81\76\115\97\116\88\109\114\111\85\110\69\85\69\113\76\90\48\86\77\86\88\52\74\120\80\89\56\102\73\55\121\120\103\80\67\118\68\43\107\100\50\98\71\86\98\101\105\107\115\85\89\85\103\65\111\65\113\88\66\101\52\55\106\106\85\109\52\108\74\55\70\89\101\65\52\79\107\108\82\87\101\109\68\120\52\105\56\85\107\74\114\103\90\86\70\86\120\48\66\68\75\83\86\80\74\118\89\112\83\83\56\78\99\66\85\51\78\116\51\50\56\106\74\105\115\56\78\98\82\68\109\73\69\84\99\69\121\83\53\83\109\88\74\69\66\54\78\82\110\51\75\98\110\78\54\53\49\66\48\65\111\101\87\116\67\90\103\71\81\109\103\107\90\81\115\85\85\55\103\56\72\55\109\43\57\51\86\117\101\81\71\120\56\65\120\54\76\74\53\118\116\51\67\68\53\71\53\53\109\73\75\97\107\111\116\120\78\51\99\73\102\56\52\70\67\88\85\83\70\108\80\102\98\109\48\65\111\100\68\72\115\120\74\87\115\47\75\53\71\81\69\103\51\118\110\120\51\102\67\74\87\77\101\88\52\107\122\70\118\77\56\86\52\54\53\69\78\111\81\76\80\66\104\50\68\98\83\68\66\76\106\98\49\118\122\67\69\85\84\77\71\103\71\89\106\54\72\118\122\116\55\68\68\107\118\100\69\106\98\80\78\85\79\90\86\49\107\43\48\49\75\112\52\88\50\87\90\87\119\116\85\85\80\121\113\71\107\119\121\89\120\103\117\53\103\72\101\75\68\72\105\120\120\89\53\81\87\98\50\51\119\101\103\48\102\97\80\98\78\101\43\67\99\48\121\78\71\43\108\75\121\86\80\100\103\98\82\109\73\105\48\121\88\86\85\100\69\78\57\104\52\77\100\82\108\76\48\82\51\83\106\99\109\53\115\50\52\98\76\100\87\112\69\48\118\117\105\76\53\51\72\80\65\103\84\117\104\121\99\43\78\89\115\68\100\107\105\75\107\48\83\90\87\83\122\74\54\119\99\122\101\71\102\69\56\120\53\79\85\81\43\69\107\108\100\75\113\110\80\73\55\54\99\115\113\69\55\86\43\119\81\56\43\105\54\101\104\87\104\51\82\113\72\115\110\106\65\81\105\54\103\70\97\98\75\72\120\120\114\110\88\86\50\71\65\99\75\56\112\85\50\50\110\104\56\100\81\81\76\53\82\107\99\120\69\51\51\107\48\106\88\110\101\110\100\112\72\98\114\50\104\55\76\71\88\106\66\90\121\68\56\73\102\55\121\116\43\103\98\78\71\104\78\110\50\108\102\73\107\68\83\114\122\49\43\69\79\47\117\106\48\70\81\90\119\47\84\117\98\43\112\49\78\77\89\77\65\101\53\67\73\106\89\48\87\105\85\111\117\43\103\122\82\80\69\108\69\70\115\56\82\86\103\82\81\82\89\100\109\113\43\112\79\122\104\57\43\71\43\109\67\114\113\56\111\73\69\66\78\99\114\74\108\90\106\111\52\48\68\49\72\88\43\104\80\75\83\56\109\121\120\98\81\104\55\101\48\80\43\116\76\81\80\98\119\70\81\67\102\108\104\105\54\112\68\50\51\107\97\98\52\119\51\75\53\84\53\98\103\80\55\54\73\56\76\119\87\122\84\75\71\115\52\102\70\68\77\103\111\55\56\112\85\65\113\76\83\74\67\120\78\50\51\81\103\67\67\54\97\99\74\90\90\50\75\100\47\103\72\122\76\112\120\110\111\119\115\111\110\102\114\105\75\108\85\47\78\118\120\98\109\106\88\50\106\109\90\107\98\68\56\107\120\102\56\69\67\75\48\97\69\99\75\57\49\55\74\99\110\111\78\105\122\86\79\108\75\85\90\115\117\104\75\73\105\117\76\80\113\81\115\51\52\48\78\55\80\101\99\108\102\57\79\98\110\90\110\71\105\99\118\80\104\57\109\90\109\119\103\88\119\77\118\54\80\52\79\53\102\98\81\89\112\90\121\82\80\110\79\110\49\117\106\111\106\51\107\115\48\83\76\100\115\121\57\101\85\76\108\87\82\85\69\73\103\115\89\80\79\86\117\113\121\121\76\74\102\43\115\99\70\72\81\56\120\85\66\68\110\48\50\112\65\50\69\109\122\54\90\51\57\49\70\107\104\56\69\113\71\74\52\57\107\80\97\48\66\70\121\69\51\76\89\74\114\101\65\111\66\57\56\79\81\114\84\84\68\52\73\99\70\73\71\69\97\102\57\48\71\121\49\43\87\98\73\105\84\87\111\121\116\105\105\103\73\114\56\116\109\43\75\122\117\66\120\114\108\97\109\107\107\84\117\74\49\110\115\89\51\82\69\117\116\85\78\68\73\49\49\57\104\84\107\66\51\98\87\83\120\118\116\120\81\85\70\55\78\79\71\88\56\89\120\43\87\99\78\108\68\118\86\43\72\50\50\90\116\71\98\86\79\121\49\110\83\53\83\82\115\110\83\105\47\90\104\118\112\82\86\54\78\86\84\80\112\90\77\49\117\113\84\109\117\50\89\67\66\115\102\54\65\122\122\109\54\105\52\57\105\114\98\54\90\75\101\109\83\121\115\71\88\77\65\120\101\101\109\53\108\121\122\84\85\43\90\113\100\68\111\87\74\81\86\73\57\89\50\70\66\85\54\74\102\73\121\48\73\108\109\79\55\83\50\43\67\90\47\112\49\87\49\80\104\69\47\83\82\74\82\65\119\50\105\51\56\74\97\90\118\72\122\74\120\101\67\114\43\118\48\100\108\105\87\48\69\101\73\116\102\103\47\53\89\99\114\53\122\118\51\111\81\85\86\103\68\79\76\53\101\56\110\88\76\57\83\115\85\108\97\114\81\75\71\119\105\74\101\117\50\89\76\79\88\99\86\81\55\76\100\101\51\79\72\113\47\57\98\109\79\113\117\98\48\98\114\50\55\105\109\111\43\70\108\81\66\54\76\112\115\98\118\68\114\75\57\72\71\67\104\54\84\102\86\107\78\49\84\76\52\89\98\118\116\99\77\86\117\43\114\66\69\111\104\43\114\116\66\55\110\86\87\47\116\51\69\77\115\99\54\122\122\65\82\65\104\69\119\100\120\82\116\110\50\71\79\81\66\111\102\102\55\80\57\112\56\104\106\48\89\52\67\75\97\99\116\86\105\83\69\120\116\88\54\105\77\49\102\80\112\100\117\110\79\69\102\76\49\110\119\105\100\57\71\85\76\117\50\87\57\68\53\84\105\71\102\113\54\69\86\85\67\87\111\107\98\114\115\67\69\66\53\89\65\65\121\112\43\79\83\47\88\80\83\99\81\104\102\106\82\79\90\87\121\118\99\102\107\103\65\116\119\90\76\106\106\119\80\77\120\50\120\117\80\78\106\109\66\66\102\50\56\72\49\87\80\122\68\101\88\101\57\83\112\88\99\122\117\52\88\77\113\90\53\50\106\49\106\108\57\86\109\106\118\48\89\90\85\69\101\109\90\86\84\72\85\43\73\70\100\50\43\73\55\72\75\49\105\76\100\114\80\119\50\79\75\72\120\52\75\113\73\76\66\112\70\113\71\65\88\77\53\81\122\73\77\99\50\97\102\84\67\70\104\52\76\73\102\75\51\122\47\97\106\69\114\102\52\50\66\75\122\70\53\109\68\69\76\74\107\55\110\108\90\57\112\47\56\121\50\43\72\104\112\105\121\105\83\84\73\51\82\109\122\70\106\78\111\77\47\54\65\70\113\116\97\50\104\97\78\113\66\90\82\100\72\109\50\53\86\52\114\121\90\111\107\75\75\105\88\105\86\76\77\106\115\115\70\53\84\121\79\76\77\85\79\122\86\121\75\110\109\109\43\103\102\104\99\88\104\107\83\66\47\97\73\97\108\75\85\89\111\107\89\73\120\56\49\121\120\84\65\69\89\56\51\47\112\82\121\76\72\48\65\69\97\68\78\122\100\108\113\105\108\73\78\98\122\114\57\78\49\73\43\110\112\99\119\102\76\55\67\52\43\65\50\103\111\101\118\100\79\77\84\70\79\50\72\114\105\114\66\118\82\65\51\87\65\68\52\108\68\108\57\121\111\48\98\71\109\109\74\110\89\102\118\69\121\108\48\67\99\121\120\120\49\100\117\70\82\50\89\117\85\48\98\72\89\52\51\72\83\54\53\70\57\51\88\54\81\72\85\111\99\111\110\48\79\79\85\73\74\67\48\112\68\67\98\53\43\55\115\106\57\75\71\75\54\66\89\67\68\71\48\79\85\117\117\118\89\55\110\43\80\116\78\54\72\51\79\111\90\51\88\107\100\120\107\109\75\122\115\57\73\75\115\121\69\76\98\115\43\104\85\112\54\77\78\51\122\99\107\112\75\71\120\55\53\120\47\122\69\70\66\108\97\113\80\115\108\105\54\119\85\119\77\43\112\47\110\112\71\113\108\75\77\73\51\73\107\119\121\110\113\122\122\53\66\119\109\108\79\106\81\87\121\82\119\53\101\56\49\107\89\116\98\79\110\75\120\105\48\110\83\80\83\85\66\105\74\72\108\121\105\120\49\53\68\118\112\104\118\107\109\77\111\79\81\84\77\52\115\107\76\71\87\103\84\85\43\90\90\85\81\103\72\113\43\65\97\116\76\116\74\81\119\70\66\88\67\88\118\73\108\83\120\51\73\99\74\111\51\86\48\77\86\78\72\89\77\71\117\106\119\75\73\84\82\51\56\80\82\84\98\122\86\88\47\119\112\48\68\118\89\51\109\84\78\113\117\57\52\53\105\89\82\105\104\48\72\106\54\81\104\83\116\119\56\111\101\99\103\76\90\86\48\86\85\57\56\49\83\52\115\122\89\89\106\112\56\89\107\77\65\100\66\107\80\88\54\118\48\78\110\119\66\121\97\77\81\109\65\76\68\80\67\68\119\49\48\89\73\99\57\71\97\88\54\67\114\99\51\121\89\109\111\85\98\81\90\75\53\101\121\76\120\51\117\67\114\47\65\114\56\73\52\69\106\90\104\112\85\55\73\84\81\88\104\108\74\76\52\83\57\53\90\113\90\73\75\55\111\90\86\76\98\79\71\43\86\119\109\77\51\102\107\98\68\66\68\84\81\76\107\71\76\99\114\75\76\114\48\120\112\119\79\65\67\106\47\83\107\81\77\101\88\50\107\98\103\51\104\80\54\116\50\83\69\106\75\109\119\108\118\89\113\110\56\100\116\50\71\112\99\56\72\80\98\112\82\77\112\68\111\52\43\54\55\87\70\117\55\80\107\71\49\76\111\48\65\112\69\84\48\67\76\78\73\121\52\87\112\72\50\49\74\117\83\108\97\86\104\75\68\103\102\82\77\66\67\55\82\68\90\113\122\116\89\108\72\81\66\52\102\119\51\65\53\55\110\56\122\78\99\111\116\65\121\55\102\104\70\109\48\43\78\118\81\82\84\101\54\86\116\99\120\85\114\52\70\83\98\48\87\82\113\102\53\52\82\74\55\65\75\122\54\71\82\68\89\50\49\118\120\114\81\72\71\79\69\116\110\90\55\110\55\47\57\108\109\81\102\117\72\90\52\56\56\98\67\55\87\73\121\57\68\47\122\105\70\118\113\71\89\79\49\86\47\89\70\74\119\115\121\78\108\114\76\83\107\109\111\122\98\119\56\100\104\101\77\55\106\70\82\68\105\101\57\109\108\118\105\99\111\66\66\110\102\55\102\54\108\81\56\107\68\107\74\116\47\75\67\117\86\78\49\71\49\51\54\104\83\105\56\118\98\54\100\114\51\99\113\76\65\113\80\97\83\97\49\115\52\114\81\117\75\83\57\108\97\65\87\83\118\116\113\65\67\103\109\66\87\74\73\116\87\83\57\54\107\73\70\99\73\111\101\74\75\86\82\55\116\116\99\74\98\69\99\104\118\118\48\67\118\99\117\115\110\114\99\89\80\57\117\52\85\66\52\106\104\89\73\104\88\105\122\65\115\67\47\77\75\101\119\77\81\66\111\89\99\97\50\69\80\84\100\55\74\113\79\57\88\119\70\88\84\100\86\55\75\107\67\103\117\117\70\116\110\70\67\100\102\66\116\117\107\88\43\111\101\117\118\107\57\47\57\47\50\110\103\49\101\78\57\86\72\111\79\112\78\107\54\84\70\52\70\119\56\101\86\49\77\98\83\110\100\114\102\111\80\70\53\82\53\107\48\66\79\118\54\97\67\50\51\115\86\48\77\54\99\70\72\89\51\113\81\119\84\65\53\100\102\118\110\80\81\74\77\106\54\109\56\73\103\43\54\108\112\110\47\111\99\52\73\85\43\68\111\114\90\110\69\89\67\110\84\55\71\50\52\82\81\90\107\108\48\79\52\116\113\52\55\55\67\73\107\120\68\107\104\75\105\111\115\99\105\74\79\79\78\70\83\53\85\71\43\74\57\69\110\114\121\99\54\54\77\114\86\75\111\112\109\99\43\115\109\81\109\117\50\114\83\86\68\54\57\55\116\65\53\114\109\88\86\110\120\51\102\72\84\86\120\105\87\109\120\101\65\66\76\120\68\111\87\80\51\85\54\87\70\75\49\115\86\71\107\72\52\88\79\54\87\47\56\51\72\82\112\55\81\98\101\122\54\55\52\75\90\72\116\54\105\121\82\80\104\114\82\65\70\113\84\85\74\75\68\97\75\55\47\112\120\108\89\117\89\108\101\103\72\73\74\106\90\51\103\75\102\102\57\70\47\65\122\88\99\103\114\66\90\115\70\84\121\98\84\90\106\122\121\43\110\51\122\105\122\49\111\115\110\121\89\76\47\83\114\72\99\53\57\85\112\120\76\114\78\100\118\51\103\89\80\99\79\88\119\72\76\50\53\81\88\52\103\117\49\54\121\89\122\101\84\109\108\48\113\53\66\53\97\43\74\80\114\97\98\81\90\97\50\83\99\103\82\110\73\116\87\84\109\77\90\119\71\49\89\84\103\77\52\99\72\112\77\101\106\76\116\49\108\107\86\119\84\85\47\50\103\73\87\112\86\55\113\79\112\70\53\103\106\117\101\104\102\47\70\119\116\122\76\74\82\107\109\48\98\106\118\71\109\81\120\75\97\117\105\115\80\53\114\74\109\85\101\56\103\110\77\53\85\116\113\115\43\99\119\48\107\89\70\47\111\89\119\109\68\48\116\97\83\85\114\84\80\81\105\79\113\117\84\122\50\117\105\110\115\120\98\67\69\112\77\98\78\53\85\72\79\98\47\77\82\97\118\87\122\112\98\56\113\76\87\99\119\104\104\110\70\86\117\50\115\80\111\109\104\122\105\74\43\106\99\114\89\107\108\84\76\74\54\80\117\70\110\112\76\122\74\75\71\119\105\53\76\56\54\104\80\112\122\43\49\100\65\113\43\81\116\101\65\101\85\117\72\112\78\86\122\75\89\70\53\70\119\117\69\51\105\77\50\86\72\111\114\67\85\97\70\115\98\107\118\67\117\51\65\100\47\82\80\76\86\114\78\55\88\121\110\52\67\108\119\67\70\121\76\50\114\114\83\105\70\57\112\74\66\89\97\106\113\49\113\51\108\74\73\117\102\85\68\117\47\108\72\98\112\116\73\43\78\116\87\53\47\75\86\119\102\52\113\74\67\84\67\56\56\117\102\107\103\113\76\97\72\81\106\89\49\104\68\73\112\88\119\77\69\116\101\105\68\53\87\102\56\66\114\73\100\121\114\72\81\113\52\49\117\101\110\89\121\56\66\106\48\47\54\90\89\72\106\65\98\71\88\66\75\79\47\117\118\117\110\82\115\90\49\72\47\121\69\97\122\48\68\73\110\57\69\65\84\69\66\55\102\99\114\74\43\97\115\122\86\112\77\100\71\68\113\100\107\81\120\120\52\78\101\76\111\43\50\110\69\47\105\107\107\122\116\69\101\97\109\55\49\50\65\85\81\108\81\82\70\57\103\51\117\104\101\47\80\66\43\73\99\118\48\106\75\48\121\99\76\68\113\70\48\100\53\77\82\74\85\87\97\43\77\79\50\101\70\121\111\87\47\115\101\53\102\100\116\74\114\102\48\106\77\47\116\101\51\65\47\86\74\65\83\121\76\67\109\69\79\118\55\104\119\88\47\77\118\118\55\112\109\65\49\103\81\119\55\53\104\78\114\122\43\100\85\65\81\65\112\110\72\78\70\83\101\51\77\54\72\66\104\90\76\83\80\88\101\73\82\109\78\105\105\102\120\78\118\83\111\51\117\100\89\77\110\47\54\83\106\115\121\103\97\80\109\110\116\111\55\100\56\84\117\105\114\65\80\76\66\111\78\73\56\103\120\106\119\120\113\97\66\85\103\89\107\84\72\89\73\90\53\43\78\77\71\115\90\79\86\119\52\111\83\48\110\98\108\102\48\81\85\53\72\113\97\50\90\106\119\67\81\83\86\111\47\77\98\102\90\76\65\111\71\43\104\83\98\120\83\50\79\89\70\54\97\75\120\118\51\104\112\111\50\57\99\112\77\77\79\112\107\108\69\103\70\90\97\99\52\49\65\99\73\73\75\80\103\83\118\117\106\65\106\87\113\76\71\104\99\121\107\52\48\104\56\102\121\89\121\111\84\78\104\70\120\56\102\112\111\90\120\72\88\106\120\104\110\100\71\48\54\85\107\71\97\89\109\67\84\101\50\48\81\122\109\68\103\43\86\67\75\80\118\74\113\80\71\80\105\101\75\70\72\83\53\102\79\97\72\53\110\112\84\65\101\110\87\104\73\119\51\111\107\86\47\80\112\68\120\102\98\88\116\74\76\100\48\106\47\65\51\107\105\72\118\110\105\119\65\81\88\77\104\70\106\113\105\80\71\121\52\82\47\109\53\49\68\122\97\121\48\88\77\71\112\112\89\51\90\102\117\48\109\47\98\85\103\111\67\112\67\112\113\100\90\97\107\68\76\68\80\90\122\79\43\69\110\106\74\78\66\110\101\80\79\110\113\55\100\114\108\84\112\50\118\99\117\122\122\48\76\113\72\121\107\68\54\113\120\88\71\110\109\48\54\106\106\43\112\73\121\52\52\70\51\108\107\79\97\43\66\43\112\53\83\117\81\115\118\56\69\71\97\57\110\88\85\72\48\55\119\54\77\82\80\104\55\80\116\70\74\108\88\68\55\104\78\116\70\115\113\102\43\107\85\87\88\72\70\87\117\78\82\80\89\102\120\43\84\108\47\106\113\50\98\52\52\48\50\83\77\110\116\98\101\72\76\89\112\52\122\80\83\100\110\100\104\77\57\99\114\68\78\82\82\113\81\103\117\99\109\78\105\100\101\116\66\89\90\120\104\112\48\83\50\67\49\67\110\108\119\56\113\49\50\99\119\55\74\72\111\102\74\82\81\70\53\49\43\68\80\69\106\79\86\83\49\75\49\100\66\90\88\112\53\80\108\50\103\99\70\120\106\107\119\122\54\67\88\88\78\105\68\66\118\102\77\67\66\53\53\89\72\57\81\102\77\49\79\101\48\113\99\71\79\70\104\47\68\71\73\72\74\81\89\50\72\90\114\109\117\109\88\98\70\84\110\98\76\87\86\112\121\104\78\79\111\82\113\100\106\116\49\56\103\121\67\74\90\73\111\67\109\54\57\122\97\116\97\107\117\72\87\49\68\80\98\73\66\80\79\48\101\77\71\68\105\47\117\76\65\101\53\52\118\111\89\81\118\106\43\119\122\48\48\84\89\110\76\55\104\80\102\54\120\51\71\43\104\98\110\71\120\72\90\90\97\47\101\52\111\121\121\77\122\82\84\47\98\48\112\68\43\113\70\114\87\122\82\116\113\113\97\104\85\65\115\73\51\56\75\48\102\47\119\48\105\103\87\43\121\51\66\89\108\122\71\105\120\88\118\53\107\76\109\110\51\86\68\71\118\71\70\68\111\105\98\97\109\81\52\113\122\71\115\112\51\120\88\107\65\81\76\120\100\104\66\52\66\75\54\115\70\108\68\68\73\73\104\113\83\109\56\67\47\105\53\48\73\77\83\68\90\97\86\56\114\77\109\106\120\66\81\72\89\70\89\100\56\117\120\80\73\110\112\53\52\68\114\76\86\75\88\54\101\48\113\104\114\76\106\115\103\54\105\90\100\51\56\88\87\53\75\52\73\52\87\50\122\43\57\71\83\78\72\119\88\114\75\104\107\67\108\98\77\101\52\48\112\111\88\119\110\86\122\78\68\51\122\88\77\108\70\85\85\112\52\71\88\54\106\74\75\110\85\117\71\105\113\48\76\110\73\118\116\103\83\99\98\100\110\81\97\118\81\99\53\120\119\100\70\102\70\100\74\120\50\113\116\68\110\83\102\68\97\73\69\65\85\52\82\106\113\109\66\122\115\54\52\101\112\50\52\55\82\108\104\105\104\70\67\101\111\70\76\115\54\47\55\89\109\52\72\88\115\119\53\115\120\73\103\66\109\117\53\74\113\57\106\114\69\80\52\104\89\79\71\108\75\83\109\100\77\122\111\65\104\81\86\53\100\111\47\47\55\48\69\65\99\111\106\69\65\75\81\98\43\78\112\68\81\65\118\67\115\88\121\102\49\109\83\79\83\79\120\70\47\115\107\103\78\83\105\66\51\67\49\120\119\120\104\98\73\67\83\50\66\55\106\49\50\116\115\77\69\53\77\117\87\122\120\118\47\71\67\51\122\67\82\74\75\120\57\88\101\81\70\52\50\115\72\89\100\109\73\110\102\74\47\47\48\86\99\69\106\119\98\67\49\103\76\43\103\74\77\114\107\48\100\74\109\117\80\77\66\86\97\56\55\81\75\78\112\74\100\79\51\101\51\117\65\43\49\87\47\68\77\90\69\77\49\80\86\101\102\110\106\110\112\98\110\89\43\69\108\101\49\106\52\71\104\73\70\112\53\50\119\117\79\113\48\49\66\84\70\109\77\106\53\83\71\101\77\89\105\111\82\81\70\108\47\86\121\84\81\67\57\80\87\57\67\110\101\81\69\67\82\89\43\50\102\70\72\105\89\121\55\50\72\75\83\70\50\109\114\74\75\112\113\111\103\83\67\81\76\50\54\105\112\71\52\55\109\82\73\86\81\48\43\122\53\57\115\113\85\109\68\83\115\112\118\54\98\118\114\101\107\55\79\105\88\122\81\122\80\54\114\51\67\101\99\114\100\84\89\74\54\67\83\55\100\74\107\110\99\122\71\101\54\111\86\47\82\55\56\89\81\51\47\54\80\85\119\75\77\55\107\71\105\73\49\118\115\88\55\68\120\76\111\80\101\109\104\112\105\76\110\76\66\79\99\82\78\77\72\85\108\115\52\81\74\70\112\105\119\85\85\72\105\121\43\72\108\90\53\57\56\76\113\102\70\100\68\48\107\112\67\105\77\81\98\48\120\122\100\43\117\76\47\56\78\86\49\53\76\49\47\75\73\75\57\83\65\106\86\76\74\79\98\122\67\88\84\74\106\100\119\74\52\97\108\85\86\75\66\118\80\77\57\79\90\48\84\121\114\108\89\79\89\107\43\72\72\111\106\102\47\67\80\106\104\80\97\116\103\109\100\56\80\111\113\56\101\52\84\89\90\68\78\101\52\76\67\68\118\116\54\107\83\67\47\85\80\43\107\66\108\43\85\54\81\65\50\82\48\74\106\67\83\103\97\68\79\86\68\53\50\56\103\110\110\122\70\120\110\85\56\119\114\98\117\102\104\66\106\107\104\82\105\116\65\114\43\113\71\107\102\82\90\121\54\107\110\108\90\121\78\90\75\110\121\65\54\43\76\72\67\116\113\113\87\73\84\99\118\108\48\119\80\88\106\47\43\79\48\114\109\102\103\50\83\54\112\90\121\65\82\77\47\108\84\68\103\106\56\115\72\65\86\117\115\103\55\112\100\115\65\71\50\85\108\88\69\122\79\113\108\76\72\114\120\97\70\122\50\84\83\74\101\116\51\102\76\87\84\122\80\122\102\74\87\121\82\78\117\106\47\99\82\104\88\106\107\43\84\43\85\102\73\89\50\114\121\117\84\104\82\119\65\54\121\120\81\112\71\114\111\99\83\89\109\98\117\55\74\106\51\110\119\47\103\68\82\69\101\82\98\54\83\97\87\107\98\80\102\99\86\102\114\100\74\121\51\70\89\108\118\112\113\67\108\70\47\89\108\104\43\104\43\119\98\47\87\118\102\47\108\76\86\77\69\98\87\97\68\83\118\75\97\115\80\79\76\97\73\55\86\83\73\112\103\103\50\54\74\67\53\103\97\78\55\109\71\68\105\53\117\66\97\79\105\109\82\83\106\89\79\52\118\52\77\115\75\82\114\103\99\66\109\56\119\83\54\49\54\115\112\68\51\65\83\108\100\88\103\98\111\73\121\118\100\100\56\110\77\71\119\65\81\89\112\84\112\56\111\104\48\107\57\98\109\120\82\48\49\118\103\90\90\50\106\107\82\100\67\114\109\88\72\99\80\56\43\67\68\78\50\111\112\121\108\99\103\110\55\90\87\76\71\57\111\101\72\65\102\119\56\77\52\47\102\118\90\97\110\114\86\106\98\50\49\110\117\109\90\122\65\110\57\88\84\74\75\99\56\89\115\111\99\102\54\66\114\69\104\69\47\100\97\83\87\87\106\70\90\43\72\76\57\72\55\119\87\112\57\55\68\102\54\108\106\66\113\107\77\90\98\73\79\116\83\57\89\65\47\69\57\114\90\81\109\48\54\105\104\98\111\74\103\101\78\47\106\120\51\54\80\51\51\108\76\97\71\82\113\43\84\68\50\77\97\117\116\81\120\77\47\78\117\82\84\82\114\88\53\76\89\86\87\84\98\107\86\48\122\51\84\75\50\115\68\78\86\80\103\99\77\52\113\112\47\110\76\77\81\55\90\102\114\80\51\110\75\49\57\118\81\122\48\122\118\70\80\81\67\77\57\51\77\117\97\121\99\99\116\87\112\87\105\87\48\122\81\122\109\85\112\100\54\99\98\113\80\103\105\74\52\109\76\56\68\76\97\98\76\101\104\66\78\100\77\70\57\53\111\49\81\43\84\84\108\107\53\49\66\121\101\98\122\51\77\99\53\52\82\113\105\116\52\77\53\116\67\78\50\83\81\65\81\68\53\88\67\114\51\43\84\67\106\112\67\65\55\72\103\121\109\99\120\79\86\90\49\76\118\66\47\119\101\111\122\83\103\54\108\108\72\120\75\79\51\86\79\82\86\85\52\71\106\68\56\74\56\84\51\110\75\115\76\89\87\80\107\100\109\68\87\65\111\116\121\118\49\51\88\68\112\99\110\74\66\121\116\89\90\86\48\85\122\43\66\56\51\118\84\79\75\67\122\100\111\88\77\78\122\101\109\116\119\67\109\52\89\87\72\69\113\78\77\104\66\57\112\72\98\51\101\56\89\82\77\47\103\51\111\76\102\67\72\102\103\84\81\79\100\116\122\69\89\77\82\67\68\53\65\80\87\54\56\98\52\104\84\116\98\47\69\65\117\53\112\49\86\103\109\119\98\76\97\52\99\85\78\115\77\114\79\85\112\72\57\82\102\100\115\67\102\104\105\119\57\74\97\86\55\115\78\108\76\79\118\75\48\112\83\115\105\70\75\98\112\54\69\80\66\70\53\111\47\118\89\100\110\50\71\55\90\79\118\86\67\70\109\104\47\83\90\112\56\75\107\73\87\82\78\43\75\48\90\85\105\51\107\85\81\69\85\50\88\83\119\43\86\101\78\49\110\99\80\121\48\109\55\54\108\80\83\118\108\82\97\108\77\111\85\53\47\112\48\104\77\117\57\102\56\78\101\119\111\68\105\48\68\81\99\68\122\107\113\98\90\75\115\67\79\101\102\67\88\66\99\85\110\81\54\50\85\75\119\73\72\67\85\117\100\73\89\50\51\109\82\86\51\77\118\69\47\57\106\82\107\118\83\65\47\114\74\84\79\113\75\71\50\118\73\57\70\100\103\83\67\47\87\117\112\99\76\56\109\70\70\97\49\77\54\111\121\47\43\87\88\110\104\106\80\113\79\97\49\117\97\99\114\82\69\55\77\78\118\77\105\57\114\79\73\82\113\76\110\105\52\86\106\102\88\98\112\112\77\89\66\55\84\120\108\119\105\76\57\69\120\51\100\84\106\105\109\97\90\74\117\76\90\109\65\65\69\53\113\120\43\103\109\106\103\72\84\111\69\98\103\107\116\52\119\76\105\83\109\86\69\54\77\82\50\117\117\81\103\107\85\109\49\88\98\111\88\102\90\47\70\85\74\66\89\43\108\112\89\86\53\119\68\73\72\111\54\120\119\85\71\84\66\71\115\102\83\122\86\88\85\107\117\50\50\47\110\70\89\73\105\43\106\49\43\53\43\72\121\97\67\111\107\106\78\98\48\83\86\88\74\68\117\73\50\70\117\65\119\54\48\69\106\90\114\74\117\55\110\57\90\82\84\74\48\89\49\88\70\121\107\109\49\105\85\74\67\105\50\72\106\82\101\122\110\80\67\122\112\52\73\52\106\49\83\98\56\118\102\74\109\90\69\86\43\81\101\109\47\43\68\113\85\121\106\122\84\117\72\74\104\77\79\119\99\67\108\102\99\78\77\112\65\107\85\56\72\99\118\69\80\43\104\49\69\56\118\120\99\119\98\55\75\106\56\47\116\112\120\109\97\110\118\120\72\99\77\101\90\74\56\87\57\85\75\72\83\108\100\90\110\117\85\51\102\77\115\56\112\55\54\108\54\70\108\68\98\73\69\104\69\82\52\104\111\57\98\104\72\55\105\67\122\83\48\68\90\109\52\52\78\75\85\107\71\109\75\68\72\79\88\55\79\89\100\115\47\98\119\74\55\52\118\69\90\52\51\52\73\108\77\76\81\72\78\122\50\113\119\79\65\84\118\114\53\72\66\51\113\105\114\55\85\50\97\54\82\119\113\106\76\71\47\111\98\67\81\83\76\78\109\98\87\110\111\72\80\113\68\119\66\76\82\73\100\86\52\97\55\111\49\109\98\56\121\117\102\74\112\104\111\102\74\73\104\52\88\88\66\79\83\57\72\71\115\87\72\119\53\98\108\50\81\48\104\85\115\114\122\110\77\52\115\51\51\54\56\113\76\100\88\52\89\108\67\82\110\83\65\79\48\117\76\47\122\50\112\50\119\110\116\51\52\120\86\83\51\85\78\74\49\112\55\79\102\117\121\71\85\110\51\113\57\120\85\49\99\69\89\76\102\106\79\76\119\69\89\85\75\83\75\74\113\120\51\112\51\88\120\48\112\108\121\53\122\68\54\99\72\47\78\87\50\84\47\84\120\57\68\88\49\80\78\81\68\108\119\109\105\57\49\108\56\105\117\48\75\80\70\89\119\112\106\74\105\49\109\69\108\70\105\83\83\57\83\103\78\120\105\101\105\110\86\111\89\75\86\72\115\85\117\78\57\66\81\43\106\100\88\89\55\115\99\116\72\116\48\105\106\113\106\49\83\55\73\116\120\77\112\48\69\57\48\66\102\57\82\47\50\68\43\90\57\84\119\67\112\71\120\118\54\79\121\50\56\55\80\43\106\115\116\118\101\66\106\112\90\109\71\47\86\78\76\66\83\49\111\71\66\85\113\118\113\69\70\104\74\71\66\54\70\69\101\121\103\78\88\107\117\108\122\77\55\120\43\67\107\116\69\57\100\66\88\55\57\65\85\99\57\50\84\122\121\84\99\53\111\113\65\89\104\82\84\110\113\86\85\80\74\116\72\83\81\114\56\84\110\120\90\76\116\114\101\49\104\73\56\76\73\72\101\115\73\78\121\103\113\108\81\117\116\100\71\53\102\117\69\66\66\112\98\56\65\120\79\65\103\82\90\81\118\50\104\117\110\67\74\82\74\85\76\105\74\75\80\114\66\84\75\115\49\71\121\71\115\90\103\80\107\85\71\51\114\43\103\65\109\97\100\75\117\71\76\84\88\100\101\56\74\80\67\106\52\122\90\116\57\86\103\100\66\108\113\86\48\81\116\115\74\97\55\71\78\104\110\66\74\54\66\56\113\75\86\117\99\102\82\67\65\114\57\116\112\110\119\81\69\77\80\111\66\98\71\49\114\122\103\47\48\112\98\51\66\69\104\69\108\107\85\55\86\90\87\81\85\97\117\57\66\117\106\106\71\122\104\99\67\109\113\70\80\89\119\75\83\75\65\107\77\90\105\55\115\90\43\51\102\104\65\108\121\54\49\69\75\118\72\104\102\66\74\49\76\105\65\120\43\114\69\113\49\84\74\122\89\78\85\54\97\69\87\90\75\110\121\84\66\121\71\49\111\49\88\70\103\77\90\72\110\118\108\122\67\53\118\54\102\117\69\66\51\69\84\43\78\99\99\70\87\118\71\122\80\53\121\82\65\103\111\116\109\85\68\81\89\77\110\71\102\89\77\114\73\122\97\55\104\118\75\73\90\74\68\102\109\97\89\120\43\122\122\108\66\82\83\110\86\121\120\69\77\82\72\65\103\82\115\116\87\47\121\102\80\115\114\71\86\49\56\53\84\118\57\73\76\120\77\78\115\121\80\78\90\99\115\49\121\43\112\98\80\98\71\48\111\77\122\114\54\117\69\75\79\68\101\69\85\104\116\83\55\82\51\116\54\56\52\51\86\116\109\68\43\79\99\43\98\43\74\73\52\116\79\103\105\111\72\82\80\50\79\69\73\72\67\54\117\50\87\110\67\97\106\70\55\117\89\56\57\122\120\89\80\51\112\99\75\72\112\81\85\116\55\53\73\72\86\80\113\43\55\104\73\111\98\43\47\106\105\66\119\103\66\105\47\103\112\47\118\88\116\122\79\85\47\68\100\55\48\55\72\80\56\114\82\68\97\109\113\48\117\82\48\85\81\55\100\71\54\99\51\106\83\69\71\68\57\82\88\81\50\116\71\47\122\84\74\99\87\105\118\70\86\98\76\103\81\48\66\109\56\110\110\98\48\88\104\75\104\43\87\72\71\53\115\82\89\106\53\57\102\77\100\79\76\73\108\73\99\111\56\119\85\75\67\53\50\65\102\107\52\49\51\52\117\56\85\90\111\105\118\116\108\55\88\52\119\78\100\80\84\57\122\48\77\88\100\49\48\89\68\76\78\118\54\122\57\90\77\72\48\57\67\53\68\121\71\69\79\118\98\98\108\48\107\71\80\100\111\51\56\90\80\51\67\107\102\90\120\110\115\73\48\69\54\113\118\70\87\109\118\107\49\57\68\107\49\114\56\49\110\119\50\99\50\73\98\111\116\115\121\71\105\87\70\86\111\87\104\54\107\79\86\54\87\71\112\50\102\79\90\83\112\69\118\99\53\53\69\75\70\110\71\90\74\75\70\84\68\72\100\66\121\99\53\65\67\74\89\56\53\73\118\89\110\115\53\72\110\117\119\81\87\67\118\80\114\57\86\48\118\99\43\52\89\73\51\78\76\47\80\84\55\106\74\79\84\99\66\109\49\80\48\70\78\80\74\54\101\119\101\86\112\53\75\55\70\52\88\83\110\102\56\119\105\69\86\51\67\121\114\90\75\119\71\56\117\85\87\79\52\84\67\79\53\88\90\103\78\65\82\114\101\75\103\75\51\80\77\122\120\85\50\107\107\99\49\119\122\108\85\81\65\65\84\90\111\84\113\108\68\56\76\82\98\98\78\79\75\106\111\66\47\68\90\119\66\97\73\71\75\81\116\87\81\75\75\68\52\88\113\121\82\109\90\88\47\51\106\72\107\57\109\66\71\65\121\106\69\48\85\47\114\49\120\78\90\90\98\115\104\105\107\75\111\77\82\111\90\43\57\81\88\79\81\76\98\121\119\84\97\112\53\55\103\83\67\55\52\101\119\71\50\65\57\85\51\65\43\111\103\116\97\117\76\88\86\86\79\97\118\65\113\121\73\104\100\109\52\102\102\79\112\98\56\72\86\67\48\98\67\110\120\71\77\118\114\75\65\116\80\57\81\53\119\82\70\54\114\65\82\82\109\55\83\117\84\67\50\116\115\84\80\74\108\110\117\81\119\71\120\78\109\57\50\82\69\120\100\118\104\47\99\99\50\54\69\104\114\103\87\83\68\121\97\56\85\105\90\47\84\54\115\71\65\48\83\70\68\78\115\83\53\85\55\69\119\77\121\89\101\113\100\74\51\88\111\52\85\86\108\57\70\107\83\74\43\118\121\109\81\68\49\82\114\120\76\121\81\106\105\50\72\105\85\71\84\86\57\48\83\81\72\77\72\113\83\83\49\72\72\88\83\52\70\77\120\80\116\48\119\90\111\49\107\112\83\52\48\98\80\48\110\108\117\48\99\104\73\72\121\69\81\78\86\101\80\89\71\84\111\86\51\69\84\55\49\99\90\106\47\98\57\47\78\101\119\66\89\111\51\89\109\109\108\102\76\88\74\75\51\81\113\108\73\67\100\118\51\101\81\120\75\55\88\54\106\104\72\97\121\74\89\77\47\119\99\75\65\82\49\74\115\101\113\116\65\121\69\81\106\78\79\51\113\55\69\114\108\81\97\52\54\74\78\109\86\110\85\70\107\54\52\80\72\122\87\113\86\83\110\76\69\79\51\76\76\51\49\88\88\55\102\119\75\77\48\56\98\49\71\121\120\78\116\103\49\109\67\53\79\120\52\117\115\80\48\84\57\100\43\108\75\65\65\71\101\97\71\77\69\116\90\68\114\66\108\104\78\88\69\72\47\87\47\109\47\116\47\118\102\102\69\103\55\89\87\122\106\103\100\98\109\115\66\104\43\81\76\73\118\82\122\105\113\120\103\107\102\106\76\43\78\47\48\69\103\48\101\81\110\57\51\101\51\112\51\73\67\66\83\101\71\78\79\110\85\105\70\65\67\78\120\107\89\87\120\85\106\57\55\112\48\47\79\87\110\106\69\111\72\100\114\108\115\70\75\119\89\79\117\67\112\104\84\54\56\47\53\114\105\68\120\100\84\85\110\120\121\66\72\83\84\47\50\101\47\118\77\109\81\65\120\116\113\108\89\112\102\72\119\76\84\113\122\103\118\102\97\52\72\76\99\97\98\68\55\86\69\111\113\119\68\77\100\53\88\84\101\86\112\71\121\84\87\47\79\122\107\122\55\55\115\73\81\77\109\51\100\114\54\68\88\115\111\49\101\121\43\68\119\101\43\114\89\115\49\120\85\108\49\78\57\82\102\79\105\117\75\116\112\70\109\112\115\69\54\88\68\43\71\112\102\85\85\84\82\114\76\121\78\83\69\108\102\112\107\81\99\109\78\79\108\104\102\84\87\77\104\73\66\54\68\108\117\54\47\83\84\89\107\98\49\118\87\121\56\80\84\73\68\81\69\110\85\74\111\118\69\51\52\79\111\68\68\97\50\119\111\89\86\68\80\65\75\81\72\79\78\107\78\90\107\74\115\72\100\71\104\47\115\69\112\72\74\85\83\87\97\50\43\106\84\111\97\84\85\85\98\90\101\106\79\57\86\85\102\116\114\99\83\48\51\113\102\86\80\82\51\115\106\88\105\90\118\100\85\81\74\88\67\79\106\99\82\74\55\43\76\48\83\86\101\80\70\76\69\70\83\80\82\73\76\114\49\66\82\68\90\49\65\49\113\119\74\52\99\66\87\77\78\79\74\105\118\89\52\105\99\57\117\54\70\110\82\78\112\89\118\47\71\108\68\99\104\48\119\112\99\83\80\102\80\100\121\88\99\43\100\84\104\65\104\109\43\54\85\71\120\99\120\70\80\43\105\52\72\102\71\106\71\102\83\89\77\101\80\68\102\121\70\49\107\122\101\89\76\100\54\85\116\72\102\121\115\66\113\43\101\54\70\81\50\118\105\82\110\101\116\118\73\114\121\110\120\114\49\99\108\65\79\119\83\103\50\70\99\108\99\101\52\65\103\80\79\83\75\79\54\117\69\98\118\83\66\85\84\86\120\72\100\105\78\71\81\79\70\54\55\54\68\72\116\52\115\48\78\54\47\101\79\115\71\83\83\112\101\111\108\102\104\65\56\103\68\89\85\101\115\97\122\109\83\119\51\89\115\90\119\108\82\85\48\50\67\121\75\68\48\54\74\56\111\105\65\82\109\71\97\118\119\56\98\51\115\87\69\112\71\83\107\53\56\86\115\101\110\78\55\109\48\43\47\86\101\122\99\108\103\73\86\111\114\67\116\103\74\121\119\106\83\85\73\110\117\66\51\85\49\116\114\78\104\117\109\56\87\90\87\108\102\52\89\111\81\80\69\120\67\81\104\107\113\88\119\54\86\76\84\79\56\112\67\86\48\100\88\105\53\81\122\78\56\50\65\86\100\84\85\83\56\88\76\65\52\88\76\83\89\57\43\50\75\74\55\50\102\105\113\83\108\50\85\85\57\102\113\114\66\75\105\54\51\51\55\75\82\74\68\110\105\68\51\50\48\72\89\43\108\85\122\109\114\102\55\66\103\76\117\72\120\121\55\100\78\103\105\66\73\108\98\86\90\103\68\97\81\118\103\86\106\71\117\117\85\54\116\119\105\112\82\65\43\76\76\55\75\122\47\116\56\103\111\82\101\90\73\57\69\77\47\79\116\79\111\109\65\104\57\88\69\74\102\82\98\80\80\78\79\51\114\102\56\83\120\66\72\55\72\97\116\50\122\66\78\107\51\76\109\98\53\116\100\105\48\107\98\56\102\89\70\100\65\101\103\85\88\87\103\114\84\57\103\103\97\119\71\69\43\86\52\108\52\55\50\52\82\107\73\76\99\114\74\120\97\112\66\117\66\71\108\48\67\90\65\66\115\48\68\50\43\122\86\68\108\112\97\68\116\121\76\53\107\75\115\54\70\43\83\115\121\66\84\119\122\120\72\77\55\77\67\106\85\115\57\112\90\109\66\49\73\109\73\97\65\88\56\85\83\81\102\113\89\53\69\99\50\120\52\80\69\86\48\117\120\56\117\65\79\119\66\85\79\49\97\90\118\50\65\78\111\118\52\102\98\79\51\78\109\80\101\52\110\120\50\90\116\88\53\53\43\76\114\98\116\97\112\76\100\122\53\107\49\113\68\102\70\52\120\119\118\116\53\90\85\104\104\104\55\78\103\116\110\65\113\66\56\107\117\110\83\106\82\120\87\110\90\98\120\56\49\74\72\122\80\83\52\88\110\69\74\117\54\98\55\57\79\52\80\65\87\54\56\54\86\53\101\81\68\109\57\73\47\110\90\121\98\66\106\121\77\87\54\109\81\83\121\82\74\50\54\111\100\69\118\73\111\117\108\110\55\77\87\78\103\49\111\80\89\51\51\97\73\57\50\74\70\88\103\90\98\118\98\105\86\80\117\49\86\118\49\106\47\57\120\104\87\43\47\98\79\51\97\77\89\69\47\68\102\65\115\106\89\112\75\67\49\83\116\107\98\114\90\82\84\86\82\54\113\109\68\102\55\74\48\73\103\53\82\81\50\104\76\105\115\98\82\90\87\105\74\70\114\87\89\107\107\102\72\78\78\118\110\99\48\116\77\109\100\80\77\104\103\79\72\75\107\88\68\50\106\75\115\86\70\79\114\118\98\106\122\100\111\106\53\119\111\43\65\56\84\104\97\80\57\53\76\78\84\102\75\48\72\75\50\87\52\83\88\110\53\79\119\100\110\75\83\70\117\86\72\79\49\68\103\107\82\69\51\106\74\75\87\84\110\84\78\100\47\54\69\88\110\74\104\83\110\98\116\43\119\110\79\72\47\87\54\117\69\113\101\85\116\52\112\116\72\102\116\106\54\87\89\80\79\55\122\106\49\118\89\105\97\110\98\78\52\104\56\101\117\115\100\74\56\54\108\86\97\120\77\82\97\71\111\100\119\67\76\90\100\101\114\101\47\67\106\117\118\68\89\99\99\57\48\76\66\76\77\74\118\75\101\82\65\90\86\106\108\43\74\121\112\52\106\66\118\120\57\76\54\110\73\65\81\109\103\110\49\52\66\110\111\99\56\113\90\112\68\104\71\79\71\55\99\83\85\118\72\51\97\120\84\53\52\108\97\117\113\69\107\75\107\97\84\108\80\115\76\72\69\77\72\119\74\116\67\87\53\50\100\66\57\65\101\88\111\109\111\43\103\86\84\97\122\48\77\86\100\89\48\77\106\66\81\67\108\111\66\109\109\85\55\90\98\43\122\70\66\53\121\81\120\100\43\113\78\47\52\85\47\109\67\113\51\75\55\109\48\67\90\88\54\108\79\97\110\100\53\111\114\107\79\55\119\103\77\101\102\121\43\102\115\78\110\120\69\106\47\109\88\120\82\105\116\81\83\77\68\117\56\47\65\74\116\52\107\122\102\87\69\57\113\108\118\110\86\79\110\114\54\88\77\65\69\66\69\53\112\104\107\75\105\113\107\53\104\68\67\83\66\49\118\107\56\71\114\67\65\80\118\88\85\108\83\75\68\78\106\47\53\69\99\72\107\83\76\87\79\57\110\65\111\104\105\70\97\67\105\50\81\79\71\67\66\67\103\80\55\112\49\78\85\77\104\53\88\54\109\69\47\103\80\69\110\70\110\115\79\109\73\65\79\49\97\43\100\80\107\83\109\105\53\117\107\108\80\88\50\108\97\80\49\118\47\71\78\52\90\71\84\99\107\105\101\111\56\66\104\112\50\107\90\79\100\109\113\54\122\49\77\52\73\97\111\43\97\70\67\56\76\100\43\110\73\90\80\83\90\98\81\113\71\73\99\79\90\90\43\72\69\50\67\121\57\78\117\97\105\90\98\118\48\107\55\70\100\100\49\66\119\107\122\53\53\122\115\70\77\48\106\48\53\71\54\50\110\79\100\51\70\113\113\71\77\109\89\50\108\102\90\116\89\72\100\114\83\101\118\69\118\68\85\81\75\56\65\57\48\43\43\103\114\52\103\79\112\117\85\119\80\108\67\75\49\83\76\48\120\120\116\89\48\119\108\110\82\83\80\98\114\57\76\101\56\114\113\43\83\54\55\83\82\68\86\114\56\101\71\87\70\88\51\106\121\101\71\107\48\48\51\110\86\48\86\99\105\116\81\70\89\69\49\97\55\50\107\109\106\72\84\89\105\67\110\101\118\107\113\113\47\105\89\79\105\75\85\73\86\82\74\89\107\104\87\71\102\80\114\68\89\100\105\105\66\83\71\109\113\52\84\48\82\68\69\89\122\116\118\102\47\103\107\71\77\119\43\103\70\119\111\70\111\54\76\52\70\80\112\106\119\119\79\65\118\102\99\55\97\79\84\107\51\73\98\114\54\84\98\119\98\68\90\97\69\74\80\52\56\65\88\121\109\51\107\105\48\86\80\74\109\73\100\122\72\99\55\88\121\105\87\103\110\121\84\73\90\119\103\72\56\54\115\89\116\120\110\65\80\76\109\90\76\50\121\84\113\103\73\102\114\112\100\78\109\120\84\43\82\51\54\112\50\88\71\110\104\65\116\70\56\119\117\54\103\117\74\69\78\115\102\100\47\121\113\100\56\55\118\47\121\87\56\122\84\71\88\119\84\114\101\107\57\70\66\102\97\65\67\102\98\66\72\110\74\103\51\110\102\109\107\101\102\101\57\110\120\108\118\79\43\43\122\71\71\105\81\67\57\100\117\103\83\115\108\109\57\50\117\118\103\54\76\86\115\117\55\43\51\48\113\55\88\88\108\109\121\68\107\122\52\102\84\111\79\103\115\103\79\115\88\57\50\111\121\122\70\119\47\66\76\119\73\116\76\53\106\119\81\103\122\83\112\115\75\74\113\54\102\56\72\78\73\50\76\68\104\72\51\101\90\81\56\115\114\87\102\97\102\67\121\117\43\43\100\122\110\86\106\70\98\78\68\66\109\122\68\86\118\101\68\117\114\119\104\103\67\102\88\76\65\106\50\101\102\104\81\77\51\74\65\105\104\69\116\65\80\112\66\83\71\121\102\55\77\120\75\119\114\76\107\47\73\85\55\74\98\118\113\97\67\100\72\78\104\56\111\52\110\121\106\51\49\105\68\122\102\98\109\71\72\49\73\119\52\87\99\66\77\83\82\102\87\49\97\104\49\122\86\84\71\118\43\97\118\104\55\71\120\101\87\82\103\68\105\76\113\72\66\107\97\82\97\47\100\73\80\47\110\120\69\52\51\67\108\116\119\83\68\108\79\100\107\98\53\103\74\79\88\100\70\67\111\110\55\56\110\55\84\116\112\99\76\52\122\112\103\69\85\43\106\73\52\47\85\100\116\54\105\106\100\53\90\120\67\90\113\108\79\85\119\85\122\68\65\108\87\100\48\71\68\67\48\55\105\77\57\115\71\69\43\48\109\87\74\88\57\97\80\111\57\100\77\71\43\112\117\50\86\88\107\47\111\49\68\109\107\90\69\113\84\50\77\101\101\69\111\47\73\113\105\103\68\90\49\106\67\79\68\122\66\69\89\87\69\120\98\66\56\106\86\84\78\85\49\113\80\48\90\69\55\114\105\106\67\82\78\80\51\50\56\118\53\98\47\48\90\97\67\52\119\84\57\111\53\98\104\114\121\50\75\53\51\50\98\55\78\103\57\48\87\49\67\57\98\98\73\121\119\118\50\100\65\90\103\85\84\86\70\67\48\73\57\81\47\76\83\108\120\102\114\43\51\87\72\119\74\65\47\98\121\122\80\100\53\103\99\115\98\114\77\121\76\52\65\73\84\99\121\88\88\117\57\121\117\87\75\100\122\100\114\115\77\108\77\99\72\102\72\48\108\78\68\116\116\73\72\72\47\120\69\110\56\71\47\83\48\53\103\54\98\116\120\70\108\99\99\77\82\68\107\86\84\112\75\43\73\56\78\67\79\81\105\103\90\114\80\89\50\90\89\119\57\118\110\82\119\74\47\103\107\81\116\56\57\76\103\75\73\81\115\101\114\85\56\67\49\67\53\120\70\52\75\88\52\88\68\57\56\56\105\71\69\71\103\116\121\84\71\114\51\110\87\118\86\75\73\74\115\52\66\107\74\80\52\114\89\113\118\67\117\74\116\51\78\69\55\47\105\120\107\77\112\110\100\70\49\47\113\110\51\97\48\118\102\68\77\112\55\84\82\84\114\56\86\55\119\74\105\57\88\65\109\68\88\54\120\68\109\83\48\102\120\97\114\98\117\81\106\52\110\102\88\97\99\87\47\104\112\98\47\84\74\66\54\56\101\118\112\75\47\56\69\113\114\78\120\49\57\89\68\73\69\86\51\99\98\48\81\89\102\82\113\74\66\51\121\101\103\71\115\75\90\53\74\55\122\110\47\76\97\86\49\121\72\85\90\43\67\71\87\80\106\71\97\77\81\76\97\116\69\70\122\66\85\57\82\71\69\55\65\102\89\78\117\48\51\117\119\43\81\101\113\117\109\106\97\51\107\99\54\68\77\106\47\57\90\66\67\87\101\87\83\90\84\47\90\86\51\117\117\119\82\99\116\79\103\79\81\119\71\87\67\112\50\47\113\108\88\49\97\78\103\83\107\51\106\74\117\70\113\85\69\122\69\80\117\65\110\86\51\114\82\84\120\43\56\120\108\122\115\78\120\109\66\81\88\85\115\111\118\43\53\121\77\50\114\81\48\106\87\99\105\85\54\85\71\100\104\83\97\117\105\90\120\56\118\65\119\47\50\104\72\118\89\102\54\69\55\104\104\74\74\49\56\81\111\52\50\80\122\81\103\76\53\111\68\100\108\80\110\118\77\113\51\81\121\117\113\88\116\72\50\47\119\53\97\71\116\82\43\71\81\105\79\65\70\105\109\78\117\84\105\43\57\90\47\56\72\88\80\78\80\51\109\97\47\85\49\106\80\52\97\74\111\117\56\72\112\53\98\89\43\107\114\84\116\101\57\100\53\114\105\108\119\70\48\89\121\79\113\75\117\104\113\56\98\104\106\111\72\113\72\68\100\76\108\104\117\75\74\57\79\88\48\70\47\90\87\98\53\57\57\101\117\80\97\86\97\98\120\70\70\107\122\100\108\112\68\103\43\100\47\54\110\78\78\57\102\66\101\76\97\49\103\106\115\97\70\43\87\69\115\109\100\108\100\112\79\119\89\52\119\47\102\111\48\69\71\51\113\43\86\78\108\89\103\72\118\81\111\116\108\52\116\71\80\53\107\113\113\73\49\85\84\114\47\73\68\104\120\52\111\100\112\84\70\68\89\109\74\49\121\43\78\120\112\51\116\119\118\53\104\86\98\112\66\104\86\73\56\116\70\100\84\71\71\104\75\66\56\117\114\103\78\117\57\115\51\87\69\105\55\57\51\50\86\76\73\67\57\55\43\118\100\48\83\111\56\112\100\122\111\70\102\99\71\108\74\72\111\115\113\122\88\107\65\108\111\54\53\119\81\112\87\75\122\76\80\82\86\75\49\117\67\49\68\110\69\116\53\112\111\113\55\104\80\107\50\71\109\114\66\104\103\105\104\55\78\56\72\43\69\122\97\102\57\57\87\73\90\57\75\50\48\43\118\55\101\105\101\102\119\110\65\52\43\102\75\106\99\117\117\48\81\116\109\82\47\120\75\113\69\88\120\52\122\54\110\67\83\49\121\113\52\70\117\97\76\52\119\49\88\50\73\121\117\70\87\68\87\115\57\108\103\98\66\108\117\109\66\43\97\55\78\54\121\99\108\82\51\74\49\103\103\100\115\101\100\57\114\110\75\71\67\76\75\117\48\50\79\79\110\119\48\69\114\88\74\54\84\57\113\101\118\117\107\106\118\77\68\122\79\56\100\116\43\56\69\113\110\97\73\118\102\85\90\107\53\106\111\83\110\51\118\89\108\55\110\97\108\109\70\106\81\53\88\84\118\69\110\77\79\118\98\103\119\84\87\115\78\115\115\107\103\53\76\81\98\75\49\113\47\68\97\97\89\75\87\98\117\106\71\83\70\54\104\70\105\82\79\84\109\71\119\114\71\86\57\79\50\53\89\51\77\98\75\54\68\74\69\83\83\81\70\119\115\98\98\48\117\121\106\47\88\105\89\122\52\117\102\85\70\90\76\55\110\71\50\110\112\50\115\76\112\55\87\83\114\54\114\113\70\48\53\56\50\110\75\43\122\76\110\111\50\77\78\70\81\118\121\102\121\112\107\74\86\112\89\53\75\57\70\110\100\98\109\102\70\112\77\119\100\54\122\119\103\75\48\48\76\108\115\85\47\101\120\100\54\65\106\101\78\115\86\47\85\85\80\65\99\85\82\97\111\109\49\117\55\68\118\56\114\113\76\47\57\116\65\114\65\105\52\100\83\49\113\97\112\54\104\98\74\105\78\107\111\77\53\49\99\57\118\102\74\72\79\43\76\99\82\55\101\47\105\111\47\68\119\90\105\72\100\101\84\122\83\104\99\85\52\85\66\97\75\109\71\71\120\50\69\122\55\55\84\48\118\83\47\50\81\119\108\54\65\54\52\110\68\67\105\80\71\103\68\51\85\103\115\98\112\85\69\54\108\97\47\115\66\98\117\89\84\122\78\69\81\87\97\103\104\85\72\110\98\103\81\112\112\90\72\106\79\56\113\121\72\110\100\88\101\84\87\69\99\99\104\102\66\120\90\81\81\87\109\107\50\55\79\75\47\109\69\47\79\110\103\103\52\98\105\108\111\49\90\47\48\51\52\99\50\90\67\115\84\81\77\68\99\73\88\122\68\108\50\121\54\99\69\68\90\78\87\116\80\52\99\43\67\47\105\56\106\111\87\105\113\86\85\106\83\118\67\79\98\52\54\107\70\107\43\86\89\107\116\113\78\88\80\85\71\113\116\121\73\75\116\74\90\120\56\97\79\51\67\115\76\83\74\120\74\57\77\117\56\48\114\82\89\100\83\66\43\99\121\47\49\118\48\57\43\56\115\117\68\85\70\119\112\70\71\120\67\122\79\106\104\83\88\57\51\105\115\98\68\82\71\103\112\55\119\122\67\77\55\85\80\98\54\115\112\54\51\106\120\43\73\100\118\54\114\89\107\97\113\109\119\78\107\84\88\119\102\79\75\81\88\121\67\76\72\104\114\74\105\89\67\87\49\121\104\49\50\70\70\69\102\111\50\84\118\90\122\106\121\67\68\73\104\122\114\72\82\48\74\121\66\87\98\106\79\55\88\49\108\76\122\55\109\74\43\110\79\113\112\79\50\87\71\51\47\76\114\81\73\80\87\121\114\100\98\69\121\115\55\83\48\57\109\103\75\121\68\114\74\98\118\104\55\117\65\69\111\89\82\70\50\80\55\66\71\103\79\110\56\68\113\70\107\119\114\81\51\50\101\56\105\57\74\67\113\108\100\89\114\65\51\49\111\69\56\54\101\55\84\66\47\53\84\72\116\73\89\101\68\57\56\87\101\118\119\104\70\107\114\99\116\105\47\99\49\122\108\85\47\100\102\67\71\88\100\43\121\51\88\52\68\114\66\99\48\66\51\78\75\111\100\81\57\84\112\90\85\107\117\118\115\111\49\65\99\68\106\117\70\84\76\101\85\54\110\66\56\52\69\70\112\48\71\120\113\116\107\85\50\68\67\67\75\65\97\47\78\103\117\69\67\97\85\88\73\75\72\118\111\69\47\85\101\70\119\57\122\87\112\72\112\99\79\88\66\54\111\81\97\70\100\79\103\116\109\121\77\49\56\49\88\84\111\120\121\110\111\115\52\79\69\110\117\66\121\103\113\78\84\72\73\74\55\66\56\54\111\82\70\73\115\85\113\55\53\76\103\81\89\103\102\56\112\65\65\117\67\117\121\116\78\56\101\105\120\104\121\120\84\54\78\75\82\85\113\87\105\109\77\121\55\47\88\80\72\43\55\80\108\88\121\72\120\47\83\83\98\113\121\83\48\114\48\50\117\114\47\43\76\77\70\86\102\100\110\106\82\114\97\54\70\98\101\112\75\73\53\66\56\106\122\77\68\50\79\82\51\116\70\66\43\80\105\56\89\115\109\115\100\97\52\83\111\106\117\50\53\100\80\110\47\111\47\99\110\52\75\86\111\81\54\105\111\115\54\112\109\70\43\88\55\67\68\66\105\77\85\52\48\55\66\117\85\102\103\51\78\53\118\84\88\103\115\77\70\117\86\71\75\89\70\98\112\57\99\83\57\71\48\56\71\100\53\112\67\122\122\51\48\101\76\50\84\122\73\112\55\81\119\109\116\43\87\116\97\72\98\110\99\105\108\43\113\47\117\112\55\85\84\54\52\69\105\103\110\89\86\82\75\113\110\52\79\75\52\87\101\81\103\104\56\70\67\115\118\69\70\68\53\98\88\107\43\116\100\78\86\43\85\112\66\122\85\71\107\54\57\101\57\97\86\121\109\99\53\78\100\84\47\68\47\68\52\65\119\71\47\98\104\100\87\88\71\84\90\104\119\52\102\77\71\52\52\85\81\69\87\100\120\49\43\89\49\71\109\108\90\53\104\69\120\53\121\90\54\81\119\106\106\47\73\122\112\47\85\74\97\114\87\90\116\76\86\120\70\54\87\113\83\74\48\113\82\120\83\81\77\71\116\102\76\77\71\77\84\52\79\57\100\103\119\90\113\108\115\113\82\83\120\90\49\53\75\68\83\73\47\81\109\83\55\112\57\113\117\120\65\54\76\43\70\90\108\122\73\72\68\81\75\76\51\97\113\122\108\90\118\72\88\102\86\117\97\65\74\79\102\85\54\115\52\121\89\53\105\57\77\119\106\65\75\111\103\54\85\66\49\120\87\76\43\71\80\70\114\70\112\102\47\54\80\98\47\87\47\110\73\52\47\43\114\53\69\69\48\73\89\115\111\72\83\115\118\52\117\75\83\74\47\98\74\50\83\105\88\108\79\98\110\98\67\82\112\86\57\120\72\89\79\87\88\67\111\97\54\99\55\109\65\89\67\104\113\76\121\103\56\101\97\50\87\90\84\69\100\84\87\89\114\69\122\71\87\89\122\56\118\78\103\120\111\71\76\112\99\101\119\102\87\87\49\100\119\113\56\109\81\68\110\50\97\71\82\49\68\52\99\80\114\73\85\118\105\70\113\85\105\75\122\48\73\115\111\105\76\86\99\51\51\79\110\50\89\57\54\67\57\118\89\88\98\51\98\54\90\100\76\121\100\56\81\54\74\80\78\74\88\109\67\104\120\100\51\82\78\71\106\104\55\119\105\68\102\56\67\90\75\102\54\80\101\98\73\110\43\55\85\67\74\56\86\104\122\56\114\107\77\72\116\117\88\71\54\67\73\85\104\56\89\82\106\79\47\85\102\99\80\75\100\105\107\49\122\81\109\50\109\49\113\84\49\83\68\65\80\104\100\69\87\77\103\103\114\77\107\99\115\56\118\108\73\87\86\116\65\76\122\57\47\83\67\49\81\105\113\54\50\103\88\67\109\57\72\116\99\107\48\113\89\78\69\81\50\86\103\119\118\80\110\48\76\121\121\111\88\73\99\90\69\81\74\68\104\77\51\110\52\115\72\52\89\113\78\119\119\68\98\109\69\88\90\80\81\114\55\111\104\70\50\86\51\51\47\112\87\68\50\106\119\102\101\100\99\104\100\84\121\66\110\122\104\87\103\120\97\122\104\47\119\83\84\88\107\84\104\50\69\110\110\100\82\69\107\118\88\85\76\120\71\74\88\111\80\65\113\88\85\56\115\100\105\81\105\66\65\119\61\61"
    local lollIIllIII = "cGdGMyktdmIsIzp7eE5xViI="
    local lollIIllIIl = "\108"
    local lollIIlIIlI = function(a, b)
        local c = lollIIlIlIl(lollIIlIllI(a))
        local d = c["\99\105\112\104\101\114"](c, lollIIlIllI(b))
        return lollIIlIllI(d)
    end
    local lollIIllIIl = "\108"
    local lollIIllIll = "\101\108\73\57\77\88\78\110\76\49\115\108\85\81\61\61"
    local lollIIllIlI = "QHZiQkloTlA+cEtBQWl3MDMzUA=="
    local lollIIlIIII = "Oz8/NGtZYjtDaUkrRkErWloyOyNzUyVycTolSjNqJDQwaE4=bi12PyZmUDh0RiF1"
    function lollIIlIlll(a, b)
        local c = lollIIlIllI(a, b)
        local d = lollIIllIlI
        return c, d
    end
    return lollIIlIlII(lollIIlIIlI(lollIIllIll, lollIIlIIIl), getfenv(0))()
end)()
