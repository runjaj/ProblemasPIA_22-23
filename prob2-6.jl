### A Pluto.jl notebook ###
# v0.19.13

using Markdown
using InteractiveUtils

# ╔═╡ 908d075b-4b67-4a90-94eb-f48e5008fecf
using Unitful, CommonMark

# ╔═╡ 59ba4fee-4b00-11ed-3ec2-f1fb4b313a14
md"""
### 2. Preparación de materia prima

#### Problema 6

La entrada de un separador de aceite y agua tiene una concentración de aceite de un 20% (v/v) con un caudal del 20 l/min y la salida de producto son 4.5 l/min con una concentración de aceite de 78%. Calcular la eficiencia de la separación.

Dato: Densidad del aceite: 900 kg/m³.

#### Solución
"""

# ╔═╡ 7938a1f5-46a8-4911-96a7-4160576d6174
md"""
Datos de la entrada del separador:
"""

# ╔═╡ 81d65e51-2b71-4d07-9d60-a7df0e924823
QF = 20u"l/minute"

# ╔═╡ a1a58b98-4524-45db-86a8-b714ee4faa54
vF = 0.2

# ╔═╡ 8dd2a8a7-3e56-44f5-aa41-ac126e86eb7a
md"""
Datos de la corriente del producto:
"""

# ╔═╡ 83c9afa2-56cf-4bb3-905d-b4e0448dd991
QP = 4.5u"l/minute"

# ╔═╡ 71ee290b-860c-4c8b-b1a2-4b95d70e13b0
vP = 0.78

# ╔═╡ ecd8f69f-6da8-427f-9925-20e0b1298f21
md"""
Densidades:
"""

# ╔═╡ 41a245fa-9bfa-4362-8dda-fceb7a1a2f67
ρo = 900u"kg/m^3"

# ╔═╡ 8d27a171-cd62-45bb-b6f2-b909d8cf15af
ρw = 1000u"kg/m^3"

# ╔═╡ 18f527fd-1899-41f2-9974-df688bc48d64
md"""
Esta función calcula el caudal másico y la fracción másica a partir del caudal volumétrico y de la fracción volumétrica:
"""

# ╔═╡ 2d6815b8-d5ad-4513-a1b9-d3c81b4b3f79
function Caudal_fracc(QF, vF)
	QFo = QF * vF
	QFw = QF - QFo
	Fo = QFo * ρo
	Fw = QFw * ρw
	F = Fo+Fw |> u"kg/minute"
	xF = Fo/F |> upreferred
	return F, xF
end

# ╔═╡ 2fe5c02b-81c3-442f-9cab-b11f8c245642
md"""
Los caudales y las composiciones de las corrientes de entrada y de producto son:
"""

# ╔═╡ 38beba8a-b68b-49d5-9c6e-dad6270c35f1
F, xF = Caudal_fracc(QF, vF)

# ╔═╡ efec7783-03e1-45ce-af0f-f76d5e82e26b
P, xP = Caudal_fracc(QP, vP)

# ╔═╡ a89141e8-8f44-4da8-bcf6-f3beee05368e
md"""
Para la corriente de residuo:
"""

# ╔═╡ 44d76106-06be-4389-9f65-2f3c4540d7c9
R = F-P

# ╔═╡ a4b1c7ea-57ef-4b01-95d4-397a5a7d8715
xR = (F*xF-P*xP)/R

# ╔═╡ a2fcedba-5fa7-4fd8-b2cd-95db4c4f30d4
md"""
El cálculo de la efectividad es:
"""

# ╔═╡ 456838ce-7070-4617-ba1d-cf619e923bd0
Efectividad = P*xP/(F*xF) * R*(1-xR)/(F*(1-xF))

# ╔═╡ ec72b3e5-f485-4795-add2-15c7e225b209
cm"""
!!! Solución
	**Eficiencia =** $(round(Efectividad; digits=3))
"""

# ╔═╡ 4c9a4546-b5a8-4936-a08a-7267c4a0a224
md"""
---
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CommonMark = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[compat]
CommonMark = "~0.8.6"
Unitful = "~1.12.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.2"
manifest_format = "2.0"
project_hash = "ca6f5764c86ac29e1316d022da3fff6230a711bd"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.CommonMark]]
deps = ["Crayons", "JSON", "URIs"]
git-tree-sha1 = "4cd7063c9bdebdbd55ede1af70f3c2f48fab4215"
uuid = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
version = "0.8.6"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "fb21ddd70a051d882a1686a5a550990bbe371a95"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.4.1"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "6c01a9b494f6d2a9fc180a08b182fcb06f0958a0"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.4.2"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.URIs]]
git-tree-sha1 = "e59ecc5a41b000fa94423a578d29290c7266fc10"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Unitful]]
deps = ["ConstructionBase", "Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "d57a4ed70b6f9ff1da6719f5f2713706d57e0d66"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.12.0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"
"""

# ╔═╡ Cell order:
# ╟─59ba4fee-4b00-11ed-3ec2-f1fb4b313a14
# ╟─7938a1f5-46a8-4911-96a7-4160576d6174
# ╠═81d65e51-2b71-4d07-9d60-a7df0e924823
# ╠═a1a58b98-4524-45db-86a8-b714ee4faa54
# ╟─8dd2a8a7-3e56-44f5-aa41-ac126e86eb7a
# ╠═83c9afa2-56cf-4bb3-905d-b4e0448dd991
# ╠═71ee290b-860c-4c8b-b1a2-4b95d70e13b0
# ╟─ecd8f69f-6da8-427f-9925-20e0b1298f21
# ╠═41a245fa-9bfa-4362-8dda-fceb7a1a2f67
# ╠═8d27a171-cd62-45bb-b6f2-b909d8cf15af
# ╟─18f527fd-1899-41f2-9974-df688bc48d64
# ╠═2d6815b8-d5ad-4513-a1b9-d3c81b4b3f79
# ╟─2fe5c02b-81c3-442f-9cab-b11f8c245642
# ╠═38beba8a-b68b-49d5-9c6e-dad6270c35f1
# ╠═efec7783-03e1-45ce-af0f-f76d5e82e26b
# ╟─a89141e8-8f44-4da8-bcf6-f3beee05368e
# ╠═44d76106-06be-4389-9f65-2f3c4540d7c9
# ╠═a4b1c7ea-57ef-4b01-95d4-397a5a7d8715
# ╟─a2fcedba-5fa7-4fd8-b2cd-95db4c4f30d4
# ╠═456838ce-7070-4617-ba1d-cf619e923bd0
# ╟─ec72b3e5-f485-4795-add2-15c7e225b209
# ╟─4c9a4546-b5a8-4936-a08a-7267c4a0a224
# ╠═908d075b-4b67-4a90-94eb-f48e5008fecf
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
