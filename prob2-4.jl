### A Pluto.jl notebook ###
# v0.19.13

using Markdown
using InteractiveUtils

# ╔═╡ 5103d352-6510-49a6-9729-c7c7f7f8b57d
using Unitful, Kroki, CommonMark, AnyAscii

# ╔═╡ 2c4311ee-4300-11ec-2c90-db0cd320fb0d
md"""
### 2. Preparación de materia prima

#### Problema 4

En una instalación de producción de aceite de oliva se utiliza una centrífuga para purificar el aceite. Una corriente de agua (w) y aceite (o) de 600 l/h con una composición de un 70 % (v/v) de agua alimenta una centrífuga de la que se obtiene una corriente de aceite (100 %) y una corriente de agua con un 2% (v/v) de aceite. Calcular la efectividad de la separación.
    
Datos: Densidad del agua = 1000 kg/m³. Densidad del aceite = 900 kg/m³

#### Solución
"""

# ╔═╡ 9f5384ed-b366-4e95-bef2-a460d5ab1907
md"""
El diagrama de la centrifuga que propone el problema es:
"""

# ╔═╡ e0ece2ae-3640-42cc-b512-eb082fed7963
Kroki.Diagram(:mermaid, """
%%{ init: { 'flowchart': { 'curve': 'stepBefore' } } }%%
graph LR

F[Agua 70% + Aceite 30%<br>Alimentación] --F--> C[Centrífuga]
C --P--> P[Aceite 100%<br>Producto]
C --R--> R[Agua 98% + Aceite 2%<br>Residuo]

classDef classES stroke:white, fill:white;
class F,R,P classES;
""")

# ╔═╡ 2694bc5b-3c63-4816-b655-c38e6b84fb57
md"""
Los datos del problema son:
"""

# ╔═╡ 5f2090f9-65bf-4b9d-b5d1-9ec1e345db41
md"""
 - Densidades:
"""

# ╔═╡ 71c075a1-92e1-4149-a0ea-afb5ed952638
ρw = 1000u"kg/m^3"

# ╔═╡ 81c947a0-a5db-46fa-acd4-9884cb703d09
ρo = 900u"kg/m^3"

# ╔═╡ a494fd70-8d3a-49c1-9ae5-b46fcd1e15c5
md"""
- Datos relativos a la entrada:
"""

# ╔═╡ 7b701e39-414b-4cef-9551-ed181703877b
QF = 600u"l/hr"

# ╔═╡ bdc2fff5-2775-4a62-93fc-cb00eea8cec1
vFw = 0.70

# ╔═╡ 78c916d9-7414-471f-8eda-5ef8e5abe665
cm"""
!!! Nota
	_Q_ indica caudales volumétricos.
	
	_v_ indica fracciones volumétricas.
"""

# ╔═╡ 84d83367-92fd-421e-8eb7-79e135ee5db3
md"""
- La corriente de producto:
"""

# ╔═╡ 36d39b5d-629b-4a38-85e1-c61a0cd52801
vPo = 1.0

# ╔═╡ c15b1fbe-62d1-4913-94d3-564db8f5731a
xP = vPo

# ╔═╡ 11081fd3-51a0-4930-b33c-0a6e14281ebe
md"""
- La corriente de residuo:
"""

# ╔═╡ b190e854-99fb-46cf-b1fc-0c892daf1ba0
pRo = 0.02

# ╔═╡ 9319a071-755d-4766-8615-0fc3063ef1b8
md"""
A partir de los datos de la alimentación podemos calcular los caudales volumétricos de la entrada:
"""

# ╔═╡ 96d9b561-a121-4c75-a7f6-e4b47bd227ce
md"""
QF = $(QF |> u"m^3/hr" |> float)
"""

# ╔═╡ ea54a66c-619e-49f4-abf1-2197f6cd7f6b
QFw = QF * vFw |> u"m^3/hr"

# ╔═╡ 126af7ba-7b5a-44a5-99ec-c8abea2a7c28
QFo = QF * (1 - vFw) |> u"m^3/hr"

# ╔═╡ e59c928b-f65a-4398-82ee-4d6c4e06b2c2
md"""
A continuación expresamos la alimentación como caudales másicos utilizando las densidades:
"""

# ╔═╡ a2d5c688-9754-4113-b206-1dff53ce33cb
Fw = QFw * ρw

# ╔═╡ 2a16a7fe-a330-4450-96b1-de10454962aa
Fo = QFo * ρo

# ╔═╡ dbcae9e1-ec33-444f-bcd6-33c98a58daf0
F = Fw + Fo

# ╔═╡ fdb9e804-3e86-451c-a7ca-03e7eeb36dab
md"""
La fracción másica del aceite en la alimentación es:
"""

# ╔═╡ 290c0657-3866-4e20-a4b9-ba54a3185805
xF = Fo/F

# ╔═╡ a4991459-692f-4d16-a211-57ba9f9c7f21
md"""
El diagrama siguiente muestra los datos que conocemos y los que desconocemos:
"""

# ╔═╡ 9eec4c47-6629-4ecc-931d-8f77b792eb16
Kroki.Diagram(:mermaid, """
%%{ init: { 'flowchart': { 'curve': 'stepBefore' } } }%%
graph LR
F[Fw = $(anyascii("$Fw"))<br>Fo = $(anyascii("$(round(unit(Fo), Fo))"))<br>F = $(anyascii("$F"))<br>xF = $(round(xF, digits=4))] --F--> C[Centrífuga]
C --P--> P[P?<br>xP = $(xP)]
C --R--> R[Rw?<br>R?<br>xR?]
classDef classES stroke:white, fill:white; class F,R,P classES;
""")

# ╔═╡ abaeb943-7b90-41ce-bf61-b98ca146ba7c
md"""
Para la corriente de resuduo:
"""

# ╔═╡ 0c66839a-7c34-44f5-ac9e-90a392fb97d2
Rw = Fw

# ╔═╡ 66072be2-60d2-4299-a39c-342dd20b81ad
QRw = Rw/ρw

# ╔═╡ 0eadd820-6036-43b8-aaa8-efe29bb09803
md"""
A partir de la composición de residuo:

$$0.02 = \frac{Q_{Ro}}{Q_{Ro}+Q_{Rw}}$$
"""

# ╔═╡ ddff4880-0828-4316-ac2a-49ab5a81b9ef
QRo = 0.02*QRw/(1-0.02)

# ╔═╡ 8b0e5a44-85d5-45a7-a108-e691166c78e0
Ro = QRo*ρo

# ╔═╡ b01ea605-d93d-4901-a219-891ded85bd64
md"""
Por tanto, el caudal másico de resido es:
"""

# ╔═╡ 0feed7c4-9c79-4c8a-8d0d-9a0975ab0f9e
R = Rw + Ro

# ╔═╡ 455f7719-b275-464a-98b1-10dab3350190
xR = Ro/R

# ╔═╡ 1d547741-91ab-4d69-a648-5b5f72b6f68a
Kroki.Diagram(:mermaid, """
%%{ init: { 'flowchart': { 'curve': 'stepBefore' } } }%%
graph LR
F[Fw = $(anyascii("$Fw"))<br>Fo = $(anyascii("$(round(unit(Fo), Fo))"))<br>F = $(anyascii("$F"))<br>xF = $(round(xF, digits=4))] --F--> C[Centrífuga]
C --P--> P[P?<br>xP = $(xP)]
C --R--> R[Rw = $(anyascii("$Rw"))<br>R = $(anyascii("$(round(unit(R), R, digits=1))"))<br>xR = $(round(xR, digits=4))]
classDef classES stroke:white, fill:white; class F,R,P classES;
""")

# ╔═╡ 60e0bf18-843c-4be5-b496-c5a0861e5994
md"""
Para la corriente de producto:
"""

# ╔═╡ e976af36-766e-44b1-91f9-558ae5079f50
P = F-R

# ╔═╡ 999be7a2-d518-4bc3-8797-ad868e79d550
md"""
La eficiencia es:
"""

# ╔═╡ a88c3ab8-6749-4d38-b69b-e2e32e8a2973
Eficiencia = P*xP/(F*xF)*R*(1-xR)/F/(1-xF)

# ╔═╡ c6c7546c-b19e-4567-be99-a185fd038dc8
cm"""
!!! Solución
	**Eficiencia =** $(round(Eficiencia; digits=3))
"""

# ╔═╡ 4215367f-206d-4be0-9a64-6cb0d411afd6
md"""
---
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
AnyAscii = "a6021bc5-2e08-4bec-afaa-bd1873282c9a"
CommonMark = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
Kroki = "b3565e16-c1f2-4fe9-b4ab-221c88942068"
Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[compat]
AnyAscii = "~0.3.1"
CommonMark = "~0.8.6"
Kroki = "~0.2.0"
Unitful = "~1.12.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AnyAscii]]
git-tree-sha1 = "cb13bdd2565ad56814487653df9574a36e934ae0"
uuid = "a6021bc5-2e08-4bec-afaa-bd1873282c9a"
version = "0.3.1"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[BitFlags]]
git-tree-sha1 = "84259bb6172806304b9101094a7cc4bc6f56dbc6"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.5"

[[CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "ded953804d019afa9a3f98981d99b33e3db7b6da"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.0"

[[CommonMark]]
deps = ["Crayons", "JSON", "URIs"]
git-tree-sha1 = "4cd7063c9bdebdbd55ede1af70f3c2f48fab4215"
uuid = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
version = "0.8.6"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "fb21ddd70a051d882a1686a5a550990bbe371a95"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.4.1"

[[Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "5158c2b41018c5f7eb1470d558127ac274eca0c9"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.1"

[[Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[HTTP]]
deps = ["Base64", "CodecZlib", "Dates", "IniFile", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "e8c58d5f03b9d9eb9ed7067a2f34c7c371ab130b"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.4.1"

[[IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[Kroki]]
deps = ["Base64", "CodecZlib", "DocStringExtensions", "HTTP", "JSON", "Markdown", "Reexport"]
git-tree-sha1 = "a3235f9ff60923658084df500cdbc0442ced3274"
uuid = "b3565e16-c1f2-4fe9-b4ab-221c88942068"
version = "0.2.0"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "5d4d2d9904227b8bd66386c1138cf4d5ffa826bf"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "0.4.9"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "6872f9594ff273da6d13c7c1a1545d5a8c7d0c1c"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.6"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "ebe81469e9d7b471d7ddb611d9e147ea16de0add"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.2.1"

[[OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "a94dc0169bffbf7e5250fb7e1efb1a85b09105c7"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.18+0"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "6c01a9b494f6d2a9fc180a08b182fcb06f0958a0"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.4.2"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "8a75929dcd3c38611db2f8d08546decb514fcadf"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.9"

[[URIs]]
git-tree-sha1 = "e59ecc5a41b000fa94423a578d29290c7266fc10"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.0"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Unitful]]
deps = ["ConstructionBase", "Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "d57a4ed70b6f9ff1da6719f5f2713706d57e0d66"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.12.0"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╟─2c4311ee-4300-11ec-2c90-db0cd320fb0d
# ╟─9f5384ed-b366-4e95-bef2-a460d5ab1907
# ╟─e0ece2ae-3640-42cc-b512-eb082fed7963
# ╟─2694bc5b-3c63-4816-b655-c38e6b84fb57
# ╟─5f2090f9-65bf-4b9d-b5d1-9ec1e345db41
# ╟─71c075a1-92e1-4149-a0ea-afb5ed952638
# ╟─81c947a0-a5db-46fa-acd4-9884cb703d09
# ╟─a494fd70-8d3a-49c1-9ae5-b46fcd1e15c5
# ╟─7b701e39-414b-4cef-9551-ed181703877b
# ╟─bdc2fff5-2775-4a62-93fc-cb00eea8cec1
# ╟─78c916d9-7414-471f-8eda-5ef8e5abe665
# ╟─84d83367-92fd-421e-8eb7-79e135ee5db3
# ╟─36d39b5d-629b-4a38-85e1-c61a0cd52801
# ╠═c15b1fbe-62d1-4913-94d3-564db8f5731a
# ╟─11081fd3-51a0-4930-b33c-0a6e14281ebe
# ╟─b190e854-99fb-46cf-b1fc-0c892daf1ba0
# ╟─9319a071-755d-4766-8615-0fc3063ef1b8
# ╟─96d9b561-a121-4c75-a7f6-e4b47bd227ce
# ╠═ea54a66c-619e-49f4-abf1-2197f6cd7f6b
# ╠═126af7ba-7b5a-44a5-99ec-c8abea2a7c28
# ╟─e59c928b-f65a-4398-82ee-4d6c4e06b2c2
# ╠═a2d5c688-9754-4113-b206-1dff53ce33cb
# ╠═2a16a7fe-a330-4450-96b1-de10454962aa
# ╠═dbcae9e1-ec33-444f-bcd6-33c98a58daf0
# ╟─fdb9e804-3e86-451c-a7ca-03e7eeb36dab
# ╠═290c0657-3866-4e20-a4b9-ba54a3185805
# ╟─a4991459-692f-4d16-a211-57ba9f9c7f21
# ╟─9eec4c47-6629-4ecc-931d-8f77b792eb16
# ╟─abaeb943-7b90-41ce-bf61-b98ca146ba7c
# ╠═0c66839a-7c34-44f5-ac9e-90a392fb97d2
# ╠═66072be2-60d2-4299-a39c-342dd20b81ad
# ╟─0eadd820-6036-43b8-aaa8-efe29bb09803
# ╠═ddff4880-0828-4316-ac2a-49ab5a81b9ef
# ╠═8b0e5a44-85d5-45a7-a108-e691166c78e0
# ╟─b01ea605-d93d-4901-a219-891ded85bd64
# ╠═0feed7c4-9c79-4c8a-8d0d-9a0975ab0f9e
# ╠═455f7719-b275-464a-98b1-10dab3350190
# ╟─1d547741-91ab-4d69-a648-5b5f72b6f68a
# ╟─60e0bf18-843c-4be5-b496-c5a0861e5994
# ╠═e976af36-766e-44b1-91f9-558ae5079f50
# ╟─999be7a2-d518-4bc3-8797-ad868e79d550
# ╠═a88c3ab8-6749-4d38-b69b-e2e32e8a2973
# ╟─c6c7546c-b19e-4567-be99-a185fd038dc8
# ╟─4215367f-206d-4be0-9a64-6cb0d411afd6
# ╠═5103d352-6510-49a6-9729-c7c7f7f8b57d
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
