module test_idses_ideographs

using Test
using IDSes.IDCs # ⿰ ⿱ ⿲ ⿳ ⿴ ⿵ ⿶ ⿷ ⿸ ⿹ ⿺ ⿻
using AbstractTrees # PreOrderDFS PostOrderDFS

# U+4EAD  亭  ⿱⿳亠口冖丁

ideograph = ⿱(⿳('亠', '口', '冖'), '丁')

buf = IOBuffer()
AbstractTrees.print_tree(buf, ideograph)
@test String(take!(buf)) == """
⿱(⿳('亠', '口', '冖'), '丁')
├─ ⿳('亠', '口', '冖')
│  ├─ '亠'
│  ├─ '口'
│  └─ '冖'
└─ '丁'
"""

predfs = AbstractTrees.PreOrderDFS(ideograph)
@test predfs isa PreOrderDFS{⿱}

postdfs = AbstractTrees.PostOrderDFS(ideograph)
@test postdfs isa PostOrderDFS

CHISE = Dict(
    ideograph => '亭'
)
@test '亭' == getindex(CHISE, ideograph)

end # module test_idses_ideographs
