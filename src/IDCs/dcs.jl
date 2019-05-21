# module IDSes.IDCs

using AbstractTrees

abstract type AbstractDC end

const UnionCharDC = Union{Char, <:AbstractDC}

macro dc2(args...)
    esc(dcs(2, args))
end

macro dc3(args...)
    esc(dcs(3, args))
end

function dcs(n, s)
    expr = :()
    for sym in s
        if n == 2
            q = quote
                struct $sym <: AbstractDC
                    a::UnionCharDC
                    b::UnionCharDC
                end
            end
        elseif n == 3
            q = quote
                struct $sym <: AbstractDC
                    a::UnionCharDC
                    b::UnionCharDC
                    c::UnionCharDC
                end
            end
        end
        push!(expr.args, q)
    end
    expr
end

@dc2 ⿰ ⿱ ⿴ ⿵ ⿶ ⿷ ⿸ ⿹ ⿺ ⿻
@dc3 ⿲ ⿳

AbstractTrees.children(tree::Union{⿰, ⿱, ⿴, ⿵, ⿶, ⿷, ⿸, ⿹, ⿺, ⿻}) = [tree.a, tree.b]
AbstractTrees.children(tree::Union{⿲, ⿳}) = [tree.a, tree.b, tree.c]

# module IDSes.IDCs
