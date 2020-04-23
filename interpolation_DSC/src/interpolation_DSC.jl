module interpolation_DSC

function f(x)
    return (x - 10)^2
end


function rec_x(xp1k, s, p, n=1, xp2k=nothing)
    xnk = xp1k + (2 ^ (n - 1) * p * s)
    if f(xnk) > f(xp1k)
        return n, xp1k, xnk, xp2k
    end
    return rec_x(xnk, s, p, n + 1, xp1k)
end

function inpol_dsc(x0k = -1, s = 0.0001, K=1, e=0.0001)
    xp1k = x0k - s
    xn1k = x0k + s
    f0k = f(x0k)
    fn1k = f(xn1k)

    if f0k > fn1k
        p = 1
        n, xp1k, xnk, xp2k = rec_x(x0k, s, p)

    else
        fp1k = f(xp1k)
        if fp1k < f0k
            p = -1
            n, xp1k, xnk, xp2k = rec_x(x0k, s, p)

        elseif fp1k >= f0k && f0k <= fn1k
            x0kn1 = x0k + ((s * (fp1k - fn1k)) / (2 * (fp1k - (2 * f0k) + fn1k)))
        end
            if s <= e
                return print(x0kn1, f(x0kn1))

            else
                inpol_dsc(x0kn1, s * K)
            end
    end
    xmk = xp1k + (2 ^ (n - 2) * p * s)
    fmk = f(xmk)

    if fmk >= f(xp1k)
        x0kn1 = xp1k + ((2 ^ (n - 2) * p * s * (f(xp2k) - fmk)) / (2 * (
                f(xp2k) - 2 * f(xp1k) + fmk)))
    elseif fmk < f(xp1k)
        x0kn1 = xmk + (((2 ^ (n - 2)) * p * s * (f(xp1k) - f(xnk))) / 2 * (f(xp1k) - (2 * fmk) + f(xnk)))
    end

    if 2 ^ (n - 2) * s <= e
        return print(x0kn1, f(x0kn1))

    else
        return inpol_dsc(x0kn1, s * K)
    end
end

export inpol_dsc
end # module
