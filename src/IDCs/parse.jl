# module IDSes.IDCs

struct IDS
    tree::UnionCharDC
end

struct IDSError <: Exception
    msg::String
end

function isidc(c::Char)
    c in '⿰':'⿻'
end

function Base.parse(::Type{IDS}, s::String)::IDS
    isempty(s) && throw(IDSError("Invalid IDS"))
    feed = collect(s)
    c = first(feed)
    if isidc(c)
        T = getfield(IDCs, Symbol(c))
        (d, next) = parseids(T, UnionCharDC[], feed[2:end])
        isempty(next) && return IDS(d)
        throw(IDSError(string("Invalid IDS about ", next)))
    else
        throw(IDSError("Invalid IDS"))
    end
end

function parseids(Tdc::Type, dcs::Vector{UnionCharDC}, feed::Vector{Char})::Tuple{UnionCharDC, Vector{Char}}
    if length(dcs) == fieldcount(Tdc)
        d = Tdc(dcs...)
        return (d, feed)
    else
        c = first(feed)
        if isidc(c)
            T = getfield(IDCs, Symbol(c))
            (d, next) = parseids(T, UnionCharDC[], feed[2:end])
            parseids(Tdc, vcat(dcs, d), next)
        else
            parseids(Tdc, vcat(dcs, c), feed[2:end])
        end
    end
end

# module IDSes.IDCs
