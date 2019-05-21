module test_idses_parse

using Test
using IDSes.IDCs # IDS ⿰ ⿱ ⿲ ⿳ ⿴ ⿵ ⿶ ⿷ ⿸ ⿹ ⿺ ⿻
using .IDCs: UnionCharDC, IDSError

ideograph = ⿱(⿳('亠', '口', '冖'), '丁')

@test parse(IDS, "⿱⿳亠口冖丁") == IDS(ideograph)
@test_throws IDSError parse(IDS, "⿳亠口冖丁")
@test_throws IDSError parse(IDS, "亠口冖丁")

(d, next) = IDCs.parseids(⿱, UnionCharDC[], collect("⿳亠口冖丁"))
@test d == ideograph
@test next == Char[]

end # module test_idses_parse
