### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ c5880e67-a7ca-4670-8e2b-7969369377de
using Unitful, CommonMark

# ╔═╡ 41d507ca-e6ba-4409-aa44-1fe3dea97b34
F = 1500u"kg/hr"

# ╔═╡ a6d223b3-ca92-4ad5-82f8-b86eaf44a8dc
md"""
La fracción másica de avena del caudal de alimentación es:
"""

# ╔═╡ b935f0a3-eb57-4bed-a526-7383475b8019
xF = 0.95

# ╔═╡ 3d6220b8-8fec-406a-8e33-a3f79ff15f53
md"""
Por lo tanto, el caudal másico de avena en la alimentación al separado de discos es:
"""

# ╔═╡ 23f115a9-2c3f-46d3-a2ac-3073ec0e13cf
Favena = F * xF

# ╔═╡ 7096a55b-6669-4203-8b18-76a75da79d31
md"""
El caudal másico de  suciedad que entra en el separador por la corriente de alimentación es:
"""

# ╔═╡ 7b51f294-5e58-49a5-8091-9db1f688b7d2
Fsuciedad = F - Favena

# ╔═╡ e664b323-42ef-4403-9410-fbd1f12cc321
Sretenida = 0.99

# ╔═╡ f0879fa6-0551-436e-b2aa-126faa19cf4c
md"""
El separador de discos retiene el $(floor(Int8,Sretenida*100)) % de la suciedad que entra en el separador, por lo tanto:
"""

# ╔═╡ ea2af6b9-576e-442d-bbeb-cf5d80b35479
Rsuciedad = Fsuciedad * Sretenida

# ╔═╡ 4cb40a3e-43b9-44b9-bcc2-45728331d527
Vsuciedad = 740u"kg"

# ╔═╡ 41fc5e24-42dc-11ec-2ad0-c1009dc5fbfb
md"""
### 2. Preparación de materia prima

#### 1

Un separador de discos se alimenta con una mezcla de avena ($(Int8(xF*100)) %) y suciedad con un caudal másico de $(F). El separador logra que toda la avena salga por la salida de producto y retienen el $(Int8(Sretenida*100)) % de la suciedad. Durante la operación normal, la suciedad queda retenida en el separador. La capacidad de almacenamiento de suciedad es de $(Vsuciedad), ¿cada cuánto tiempo habrá que limpiar el separador de discos?

##### Solución

El caudal másico de la alimentación es:
"""

# ╔═╡ a6905f89-991d-4682-975e-b0ff23aef565
md"""
El tiempo que debe transcurrir para que se acumulen $(Vsuciedad) en el separador será:
"""

# ╔═╡ 68f53ef2-3243-4380-bf11-ac4fa68040c5
t = Vsuciedad/Rsuciedad

# ╔═╡ b45fe982-78c4-4c7e-a820-9e08854834e4
cm"""
!!! Solución
	**t = $(round(typeof(t), t; digits = 1))**
"""

# ╔═╡ 6c86ecfe-e40a-45d5-b8aa-e9ad15efbc93
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

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

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

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "3d5bf43e3e8b412656404ed9466f1dcbf7c50269"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.4.0"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[URIs]]
git-tree-sha1 = "e59ecc5a41b000fa94423a578d29290c7266fc10"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.0"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Unitful]]
deps = ["ConstructionBase", "Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "d57a4ed70b6f9ff1da6719f5f2713706d57e0d66"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.12.0"

[[libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"
"""

# ╔═╡ Cell order:
# ╟─41fc5e24-42dc-11ec-2ad0-c1009dc5fbfb
# ╟─41d507ca-e6ba-4409-aa44-1fe3dea97b34
# ╟─a6d223b3-ca92-4ad5-82f8-b86eaf44a8dc
# ╟─b935f0a3-eb57-4bed-a526-7383475b8019
# ╟─3d6220b8-8fec-406a-8e33-a3f79ff15f53
# ╠═23f115a9-2c3f-46d3-a2ac-3073ec0e13cf
# ╟─7096a55b-6669-4203-8b18-76a75da79d31
# ╠═7b51f294-5e58-49a5-8091-9db1f688b7d2
# ╟─f0879fa6-0551-436e-b2aa-126faa19cf4c
# ╠═e664b323-42ef-4403-9410-fbd1f12cc321
# ╠═ea2af6b9-576e-442d-bbeb-cf5d80b35479
# ╟─a6905f89-991d-4682-975e-b0ff23aef565
# ╟─4cb40a3e-43b9-44b9-bcc2-45728331d527
# ╠═68f53ef2-3243-4380-bf11-ac4fa68040c5
# ╟─b45fe982-78c4-4c7e-a820-9e08854834e4
# ╟─6c86ecfe-e40a-45d5-b8aa-e9ad15efbc93
# ╠═c5880e67-a7ca-4670-8e2b-7969369377de
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
