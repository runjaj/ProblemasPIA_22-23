### A Pluto.jl notebook ###
# v0.19.18

using Markdown
using InteractiveUtils

# ╔═╡ 26e02b24-7c66-11ed-3992-2db5476f680b
using Plots, Trapz, PrettyTables, CommonMark, Latexify, Kroki, LaTeXStrings

# ╔═╡ 545b41db-f31f-41ea-bd71-a83e1a9f2d31
md"""
## Solución

### Datos
"""

# ╔═╡ 45191d34-e4ff-4136-8262-c98cffb4254d
t_cal = [0., .5, 1., 1.5, 2., 2.5, 3., 3.5, 4 , 4.5, 5, 5.5, 6, 6.5, 7, 7.5, 8.0]

# ╔═╡ 5ae5790a-33d0-4e90-9082-3e5725eb0df4
T_cal = [NaN, 111.5, 115., 116.5, 117., 117.5, 117., 116.5, 115, 112.5, 107.5, 100., 97.5, 96., 95.3, 95., 95.]

# ╔═╡ 40ed2e40-16c7-4e44-a9d3-4a8a19b3c156
T₀ = T_f = 60

# ╔═╡ f386507d-8389-4113-addb-51e80585a7b3
Tₘₐₙ = 125

# ╔═╡ bf5246a8-d527-4ba9-be6f-8f7a78eb19a7
tₘₐₙ = 4

# ╔═╡ 5bbc3ec4-eca9-4a1e-bffd-7bcd0b19c0d9
F₀ = 13.5

# ╔═╡ ea79e3dc-31b6-43a7-9d6f-cc0e32dd2227
frac_cal = 2/100

# ╔═╡ 2b4d3141-5f8a-4966-ae70-46488acc8e0d
frac_enf = 1/100

# ╔═╡ 5f7c744b-3d62-4856-a90c-a1c4acfbd0cb
cm"""
# Problema 3

El Sr. Barrufet, magnate y presidente de uno de los principales holdings del sector agroalimentario, tuvo a bien recibir el año pasado a los alumnos de la UdL. La recepción tuvo lugar en una de sus fábricas, concretamente la dedicada a conservas vegetales de Verdú.

Entre los diversos productos allí elaborados, destacan las conservas de las setas autóctonas de la zona (_Bolletus terrafermae_, X.), cuya exquisitez no tiene parangón. Estando en la sala de autoclaves, comentaba airadamente nuestro anfitrión las vicisitudes por las que pasó un licenciado en ciencia y tecnología de alimentos que contrató “ex profeso” hasta establecer el programa de esterilización de las citadas setas. (Lo que se le olvidó comentar fue que lo despidió una vez tuvo conocimiento de los baremos de esterilización a aplicar al producto y de sus pretensiones económicas).

Dicho programa conseguía la esterilidad comercial perseguida y era el que se estaba aplicando en los autoclaves durante la visita a las instalaciones. En líneas generales -- decía orgulloso el Sr. Barrufet -- consiste en introducir los botes de las setas a una temperatura de $T₀ °C (en el punto crítico) en el autoclave y elevar la temperatura linealmente mediante la inserción de vapor hasta $Tₘₐₙ °C. Una vez alcanzado este valor, se mantiene constante durante $(tₘₐₙ) minutos. A continuación, se enfría linealmente a contrapresión hasta unos $T_f °C. En definitiva, se consigue un F₀ total de $(F₀) min. La fase de calentamiento y enfriamiento representan un $(frac_cal*100) y un $(frac_enf*100) % del valor anterior.

Con estas y otras disquisiciones estaba nuestro personaje cuando, de pronto, se disparó la horrísona alarma de uno de los autoclaves. Todo el grupo visitante y personal laboral próximo al lugar del incidente, precedidos por un asustado y algo contrariado presidente del holding, corrimos en tropel hacia aquel autoclave a ver que ocurría.

–¡¡Que vengan los de mantenimiento!! - gritó con autoridad el Sr. Barrufet.

Al instante llegaron (asombroso).

Se había producido exactamente al minuto de iniciarse el programa de esterilización, una fuga de vapor en la junta entre la conducción del fluido calefactor y el propio autoclave.

Mientras se reparaba la avería, nervioso, y sin duda recordando en qué malahora no accedió a las condiciones del técnico que despidió, casi sollozando, el Sr. Barrufet decía:

–¿Y qué haremos ahora? Nunca me había pasado esto. Los de mantenimiento me arreglan el escape rápido -- por la cuenta que les traía --, pero ¿cómo acabo después de la avería el programa de esterilización? ¿Podrían ayudarme? Contrato fijo a uno de estas chicas o chicos, si me dicen que debo hacer.

Naturalmente supieron qué había que hacer. Se fueron al registrador de la temperatura y anotaron los siguientes datos correspondientes al período de avería, justo entre el primer minuto del programa inicial y el momento en que la temperatura empezó a subir otra vez linealmente, según el programa normal:

$(pretty_table(HTML, hcat(t_cal, T_cal); header=(["t (min)", "T (°C)"])))

Con esta información y la aportada inicialmente por el Sr. Barrufet fueron capaces de:

1. Calcular ``z``, ``f_h``, ``f_c``, temperatura en el punto crítico en el momento de iniciarse la avería
2. Trazar la curva de penetración de calor en el punto crítico del programa normal de trabajo, así como evaluar el valor letal de cada una de las zonas.
3. Hacer lo mismo pero para aquella azarosa partida y garantizando el mismo grado de esterilidad que se conseguía en el caso anterior.

Epílogo: Como todos los alumnos fueron capaces de resolver el problema planteado por el Sr. Barrufet, al final tuvieron que decidir quién se quedaba a piedra, papel o tijera. La fortuna y la intercesión del santo local hicieron justicia con el empollón del grupo, Pere Clever, quien me imagino continua en la empresa todavía, si el Sr. Barrufet no ha sufrido un nuevo acceso de racanería.
"""

# ╔═╡ bc7a6764-336a-4791-a003-125e2992a4a0
tₐᵥ = 1

# ╔═╡ 997ee351-e03a-464a-87c4-2ae9ae0defa0
md"""
### 1. Calcular ``z``, ``f_h``, ``f_c``, temperatura en el punto crítico en el momento de iniciarse la avería

En este caso tenemos un tratamiento que consiste en una etapa de calentamiento lineal, una etapa de mantenimiento de temperatura constante y una etapa final de enfriamiento, tal como se muestra en la figura siguiente.
"""

# ╔═╡ 38e19ce0-5f2d-484b-b0c0-3a6849d2ac41
svgbob"""
    T | 
      |
 125°C|....... +-----------+                                 
      |       /:           :\                                
      |      . :           : \                               
      |     /  :           :  \                              
      |    .   :           :   \                             
      |   /    :           :    \                            
      |  .  𝟭  :     𝟮     :  𝟯  \                           
  60°C| /  cal :   mant    : enf  \
      |        :           :       
      +------------------------------
               |<- 4 min ->|      t
"""

# ╔═╡ de9d885e-9d96-46f8-baa4-072649407bf6
md"""
Como conocemos la $F_0$ total del tratamiento podemos encontrar las letalidades de las etapas de calentamiento y enfriamiento, ya que:
"""

# ╔═╡ 03dc8bdc-735c-4fd6-a8a9-cef69938bda5
latexify(["F₀ = L₁ + L₂ + L₃", "L₁ = $frac_cal*F₀", "L₃ = $frac_enf*F₀"], env=:align)


# ╔═╡ 0eaa0764-2bec-4296-8bb3-333f2887133b
md"""
Para los cálculos, tomaremos como temperatura de referencia:
"""

# ╔═╡ 8d161e61-c8bf-48fe-bb9c-585dd0e54c74
Tᵣ = 121.1

# ╔═╡ c66a9db2-f335-467e-b679-0428fe3249ce
md"""
La letalidad de la etapa de mantenimiento será:
"""

# ╔═╡ 865b1d0a-0600-40f3-935b-d9f3e35d1332
@latexdefine L₂ = F₀ - frac_cal*F₀ - frac_enf*F₀ env=:eq

# ╔═╡ f6fc210a-9ded-4c28-96c0-1fcbc1306a0e
cm"""
A partir del conocimiento de que la duración de la etapa de mantenimiento es de $tₘₐₙ, podemos encontrar el valor de ``z``:
"""

# ╔═╡ 54a564ae-49bf-4ac5-9645-ee624b264513
@latexify "L₂ = t_man*10^((Tₘₐₙ-Tᵣ)/z)"

# ╔═╡ 6a4bbe1f-34f5-44fd-915c-40ef24b36a1d
md"""
Despejando se encuentra:
"""

# ╔═╡ df32f4bc-b7af-4354-80e0-ba31bcea0d3c
@latexdefine z=(Tₘₐₙ-Tᵣ)/log10(L₂/tₘₐₙ) fmt=x->round(x; digits=2)

# ╔═╡ 84e03f20-8982-48de-89d1-e98de8d298f2
md"""
Conocidos los valores de las letalidades de calentamiento y de enfriamiento, ya podemos calcular sus velocidades $f_h$ y $f_c$:
"""

# ╔═╡ bcbf9fe3-12ee-4d9f-b570-f0b181655aa5
@latexdefine L₁ = frac_cal*F₀ env=:eq

# ╔═╡ c5a9ac7a-91ea-4495-ba1f-8998103dddc4
@latexdefine L₃ = frac_enf*F₀ env=:eq

# ╔═╡ 4889bb1c-807d-4594-bbb0-dc4934fe264d
md"""
Para la etapa de calentamiento:
"""

# ╔═╡ 389de9c7-1fc0-42b7-9050-a8b44585b24d
@latexify "L₁ = z/(f_h*ln(10))*(10^((Tₘₐₙ-Tᵣ)/z)-10^((T₀-Tᵣ)/z))" env=:eq

# ╔═╡ 722bf980-27a1-475c-89c4-4956d4dd2e84
md"""
Por lo tanto:
"""

# ╔═╡ 35425fbf-5007-407b-b89a-41307c57e0c1
@latexdefine f_h = z/(L₁*log(10))*(10^((Tₘₐₙ-Tᵣ)/z)-10^((T₀-Tᵣ)/z)) env=:eq 

# ╔═╡ 18309d45-d1c5-42fa-aa02-98ff46b8c467
md"""
De manera análoga para la etapa de enfriamiento:
"""

# ╔═╡ 1e43d546-1e02-43c3-8f40-6d7ba37a217a
@latexdefine f_c = z/(L₃*log(10))*(10^((T_f-Tᵣ)/z)-10^((Tₘₐₙ-Tᵣ)/z)) env=:eq

# ╔═╡ ee9967b7-a28b-4d91-a98a-e04a56408401
cm"""
!!! note "Solución"

	``z = `` $(z; digits=1) °C

	``f_h=`` $(round(f_h; digits=1)) °C/min

	``f_c=`` $(round(f_c; digits=1)) °C/min
"""

# ╔═╡ c7cf5819-5348-4aa7-9543-95398234ad23
md"""
### 2. Trazar la curva de penetración de calor en el punto crítico del programa normal de trabajo, así como evaluar el valor letal de cada una de las zonas.

La duración de la etapa de enfriamiento es:
"""

# ╔═╡ 6fa22920-a9af-40ec-a57d-72f4923af097
@latexdefine t_1 = (Tₘₐₙ - T₀)/f_h env=:eq

# ╔═╡ e6243875-da4a-43bc-ab88-254def5dbc82
md"""
La duración de la etapa de enfriamiento es:
"""

# ╔═╡ 40e77682-3234-413e-86fb-cb1ebff29b37
@latexdefine t_fin = (T_f - Tₘₐₙ)/f_c env=:eq

# ╔═╡ 299d5a9f-1475-4f61-b83e-c87825ccfb5f
md"""
El perfil del tratamiento queda de esta manera:
"""

# ╔═╡ 235a8e84-04fd-451d-a128-80a6562d5f58
begin
	plot([0, t_1], t->T₀+f_h*t, lw=2, legend=false, xlabel="t (min)", ylabel="T (°C)")
	plot!([t_1, t_1+tₘₐₙ], [Tₘₐₙ, Tₘₐₙ], lw=2)
	plot!([t_1+tₘₐₙ, t_1+tₘₐₙ+t_fin], t->Tₘₐₙ+f_c*(t-t_1-tₘₐₙ), lw=2)
end

# ╔═╡ 73b2a22d-5cf4-42bf-a65c-a2085a0577fc
cm"""
!!! note "Solución"

	``L_1 =`` $L₁ min

	``L_2 =`` $L₂ min

	``L_3 =`` $L₃ min
"""

# ╔═╡ e8453875-3323-4e37-a7b5-57f4dfa50e03
md"""
### 3. Hacer lo mismo pero para aquella azarosa partida y garantizando el mismo grado de esterilidad que se conseguía en el caso anterior.


Sabemos que la curva de calentamiento es lineal hasta $tₐᵥ, a partir de ese momento se produce la avería. Los datos de tiempo y Temperatura hasta que se repara la avería muestran este perfil:
"""

# ╔═╡ 9993a1d9-2aa5-4b53-81b0-d82a59cfa52d
begin
	plot(t_cal, T_cal, xlabel="t", ylabel="T", legend=false, lw=2)
	vline!([0])
end

# ╔═╡ dc4685b5-65d9-43dd-898f-e14c0eb6f126
md"""
Desconocemos la temperatura en el momento de producirse la avería, pero podemos calcularla sabiendo que el calentamiento es lineal:
"""

# ╔═╡ 733ad321-5e67-490a-a06a-cd6afce4487e
@latexdefine Tₐᵥ = T₀ + f_h*tₐᵥ fmt=x->round(x; digits=1)

# ╔═╡ 2f608675-1fee-48d0-beaa-6345fa6cf0ba
md"""
El tiempo final de la etapa de calentamiento, es decir, cuando acaba la fase lineal de calentamiento, tras la avería, es:
"""

# ╔═╡ 2ba00a4d-e118-4b01-8b45-8e4315446bda
md"""
Lo que significa que la fase de calentamiento queda de la siguiente manera:
"""

# ╔═╡ 434017ed-e800-4af4-908b-7e5840d781b1
begin
	t_cal´ = t_cal.+tₐᵥ
	T_cal´ = vcat(Tₐᵥ, T_cal[2:end])
	xticks_cal = [0, tₐᵥ, t_cal´[end], (Tₘₐₙ-T_cal´[end])/f_h+t_cal´[end]]
	yticks_cal = [T₀, Tₐᵥ, T_cal´[end], Tₘₐₙ]

	global calplot = plot([0,1], t->T₀ + f_h*t, fill=0, fillalpha=0.3, xlabel="t (min)", ylabel="T (°C)", legend=false, lw=2, ylims=(60, 130),  xticks=xticks_cal, xrotation=45, yticks=yticks_cal, formatter=x->string(round(x;digits=1)), title="Calentamiento")
	calplot = plot!(t_cal´, T_cal´, fill=0, fillalpha=0.3, lw=2)
	calplot = plot!([9,(Tₘₐₙ-T_cal´[end])/f_h+t_cal´[end]], t->T_cal´[end] + f_h*(t-t_cal´[end]), fill=0, fillalpha=0.3, lw=2)
	for i in 1:length(xticks_cal)-1
		calplot = annotate!((xticks_cal[i+1]+xticks_cal[i])/2, 65, L"L_%$i'")
	end
	plot(calplot)
end

# ╔═╡ 0d74df86-e72d-4cf9-ad2f-b8c5f4495227
@latexdefine tᵣₑₚ = (Tₘₐₙ-T_cal´[end])/f_h+t_cal´[end] fmt=x->round(x; digits=1)

# ╔═╡ 96e4f3c8-dd07-4180-9c8a-4fe1c4bf13b9
md"""
Como vemos tenemos la fase de calentamiento divida en tres zonas, lo que supone el cálculo de tres letalidades ($L_i$, $L_2$ y $L_3$). La letalidad de la fase de enfriamiento será $L_5$. El valor de $F_0$ continuará siendo el mismo que para el tratamiento normal, lo que siginifica que la letalidad de la nueva etapa de mantenimiento será:
"""

# ╔═╡ 10d3f47b-bf14-4ce1-85b1-4ef7658428c1
@latexify L₄' = F₀ - L_1' - L_2' - L_3' - L_5'

# ╔═╡ d829d83a-c80f-4b83-8f30-db206315e1f5
md"""
Vamos a calcular cada una de las letalidades anteriore:

 $\mathbf{L_1'}$

Se trata de una fase de calentamiento lineal entre el tiempo inicial y el tiempo $tₐᵥ:
"""

# ╔═╡ 46edcd70-646d-4682-918d-fe3516daa84f
@latexdefine L₁´ = z/(f_h*log(10))*(10^((T₀ + f_h*tₐᵥ- Tᵣ)/z)- 10^((T₀-Tᵣ)/z)) fmt=x->round(x; sigdigits=2) env=:eq

# ╔═╡ d71f2545-e40c-4f9c-96d7-c5c2af623f1d
md"""
Para calcular la temperatura final de la etapa, hemos utilizado la ecuación de la recta:
"""

# ╔═╡ 8eafc2cb-e5bc-4156-b0cd-91b9bc6923eb
@latexify T(t) = T₀ + f_h*t

# ╔═╡ 1c5f68c1-e47f-4ead-8962-0032684d4f35
md"""
 $\mathbf{L_2'}$

Esta fase requiere el cálculo de la letalidad numéricamente.

En primer lugar, calculamos $f(t) = 10^\frac{T-T_{ref}}{x}$:
"""

# ╔═╡ 1d6a20c2-3a0d-41da-a887-68a0af9526b6
begin
	@latexdefine f_2 = @. 10^((T_cal´-Tᵣ)/z)
end

# ╔═╡ bc1b3a5c-33ad-433f-9e1d-ffa797fb33a9
md"""
A continuación calculamos la intgral por el método de los trapecios:
"""

# ╔═╡ 9029511c-557c-4907-ad5e-03a946ef4326
@latexdefine L₂´ = trapz(t_cal, f_2) fmt=x->round(x; digits=2)

# ╔═╡ e8f8e518-0b70-4bda-b771-abec4c0077ed
md"""
 $\mathbf{L_3'}$

Nuevamente nos encotramos una etapa lineal:
"""

# ╔═╡ b6146d6b-9b89-4076-8f3a-2296c5111450
@latexdefine L₃´ = z/(f_h*log(10))*(10^((Tₘₐₙ- Tᵣ)/z)- 10^((T_cal[end]-Tᵣ)/z)) env=:eq

# ╔═╡ 1826d156-9724-430a-b404-1c6a13cc2214
md"""
 $\mathbf{L_5'}$

La última etapa es exactamente igual que la etapa 3 de la operación normal:
"""

# ╔═╡ ff6347fb-6f98-4175-9cc0-8a91382463af
@latexdefine L₅´= L₃ env=:eq

# ╔═╡ 5aba491f-7ebe-481c-a251-e9f65ae771df
md"""
 $\mathbf{L_4'}$

La letalidad de la nueva etapa de mantenimiento es:
"""

# ╔═╡ 8c76605d-2cfa-4652-8bed-1b8cf38aa672
@latexdefine L₄´ = F₀ - L₁´ - L₂´ - L₃´ - L₅´ fmt=x->round(x; digits=2)

# ╔═╡ 887540e9-e8f8-4065-9bb3-77d9ae2fb563
md"""
Como la letalidad está calculada para la temperatura de referencia, tenemos que obtener el tiempo equivalente a la temperatura de la etapa de mantenimiento:
"""

# ╔═╡ 593aa6be-cab0-4dbb-afd1-c4717d067260
@latexdefine Δt´ = L₄´*10^((Tᵣ - Tₘₐₙ)/z) fmt=x->round(x; digits=2) env=:eq

# ╔═╡ ba4c2023-1b5e-4522-b9b5-593b94874857
md"""
Este es el perfil de esta operación, se muestran las diferentes etapas coloreadas:
"""

# ╔═╡ 73244f1e-f8b7-4a07-b5f0-6fc1bbeed0e0
begin
	
	xticks_av = [0, tₐᵥ, t_cal´[end], tᵣₑₚ, tᵣₑₚ+Δt´, tᵣₑₚ+Δt´+t_fin]
	yticks_av = [T₀, Tₐᵥ, T_cal´[end], Tₘₐₙ, Tₘₐₙ, 60]
	
	plot([0,tₐᵥ], t->T₀ + f_h*t, fill=0, fillalpha=0.3, xlabel="t (min)", ylabel="T (°C)", legend=false, lw=2, ylims=(60, 130),  xticks=xticks_av, xrotation=90, yticks=yticks_av, formatter=x->string(round(x;digits=1)))
	plot!(t_cal´, T_cal´, fill=0, fillalpha=0.3, lw=2)
	plot!([9,(Tₘₐₙ-T_cal´[end])/f_h+t_cal´[end]], t->T_cal´[end] + f_h*(t-t_cal´[end]), fill=0, fillalpha=0.3)
	plot!([tᵣₑₚ, tᵣₑₚ+Δt´], [Tₘₐₙ, Tₘₐₙ], fill=0, fillalpha=0.3)
	plot!([tᵣₑₚ+Δt´, tᵣₑₚ+Δt´+t_fin], t->Tₘₐₙ+f_c*(t-tᵣₑₚ-Δt´), fill=0, fillalpha=0.3)
end

# ╔═╡ d94039c9-973c-4e92-a69e-d2a69b989c98
cm"""
!!! note "Solución"

	``L_1 =`` $(round(L₁´, digits=2)) min

	``L_2 =`` $(round(L₂´, digits=2)) min

	``L_3 =`` $(round(L₃´, digits=2)) min

	``L_4 =`` $(round(L₄´, digits=2)) min

	``L_5 =`` $(round(L₅´, digits=2)) min

	``\Delta t´ =`` $(round(Δt´, digits=2)) min
"""

# ╔═╡ d0509f6b-e295-4702-8aec-7dd1f7bdea56
md"""
---
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CommonMark = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
Kroki = "b3565e16-c1f2-4fe9-b4ab-221c88942068"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Latexify = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PrettyTables = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
Trapz = "592b5752-818d-11e9-1e9a-2b8ca4a44cd1"

[compat]
CommonMark = "~0.8.7"
Kroki = "~0.2.0"
LaTeXStrings = "~1.3.0"
Latexify = "~0.15.17"
Plots = "~1.38.0"
PrettyTables = "~2.2.2"
Trapz = "~2.0.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.3"
manifest_format = "2.0"
project_hash = "fb968dd41cad86b58b9e9e44597e6d1c0a1d1a0e"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "43b1a4a8f797c1cddadf60499a8a077d4af2cd2d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.7"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "e7ff6cadf743c098e08fca25c91103ee4303c9bb"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.15.6"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "38f7a08f19d8810338d4f5085211c7dfa5d5bdd8"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.4"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "ded953804d019afa9a3f98981d99b33e3db7b6da"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.0"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Random", "SnoopPrecompile"]
git-tree-sha1 = "aa3edc8f8dea6cbfa176ee12f7c2fc82f0608ed3"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.20.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "d08c20eef1f2cbc6e60fd3612ac4340b89fea322"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.9"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.CommonMark]]
deps = ["Crayons", "JSON", "URIs"]
git-tree-sha1 = "86cce6fd164c26bad346cc51ca736e692c9f553c"
uuid = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
version = "0.8.7"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "00a2cccc7f098ff3b66806862d275ca3db9e6e5a"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.5.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "e8119c1a33d267e16108be441a287a6981ba1630"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.14.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bad72f730e9e91c08d9427d5e8db95478a3c323d"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.8+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "d972031d28c8c8d9d7b41a536ad7bb0c2579caca"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.8+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "051072ff2accc6e0e87b708ddee39b18aa04a0bc"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.71.1"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "501a4bf76fd679e7fcd678725d5072177392e756"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.71.1+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "d3b3624125c1474292d0d8ed0f65554ac37ddb23"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.74.0+2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "Dates", "IniFile", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "2e13c9956c82f5ae8cbdb8335327e63badb8c4ff"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.6.2"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "49510dfcb407e572524ba94aeae2fced1f3feb0f"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.8"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "f377670cda23b6b7c1c0b3893e37451c5c1a2185"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.5"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b53380851c6e6664204efb2e62cd24fa5c47e4ba"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.2+0"

[[deps.Kroki]]
deps = ["Base64", "CodecZlib", "DocStringExtensions", "HTTP", "JSON", "Markdown", "Reexport"]
git-tree-sha1 = "a3235f9ff60923658084df500cdbc0442ced3274"
uuid = "b3565e16-c1f2-4fe9-b4ab-221c88942068"
version = "0.2.0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "ab9aa169d2160129beb241cb2750ca499b4e90e9"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.17"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c7cb1f5d892775ba13767a87c7ada0b980ea0a71"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+2"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "946607f84feb96220f480e0422d3484c49c00239"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.19"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "cedb76b37bc5a6c702ade66be44f831fa23c681e"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "03a9b9718f5682ecb107ac9f7308991db4ce395b"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.7"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "a7c3d1da1189a1c2fe843a3bfa04d18d20eb3211"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "df6830e37943c7aaa10023471ca47fb3065cc3c4"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.3.2"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6e9dba33f9f2c44e08a020b0caf6903be540004"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.19+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.40.0+0"

[[deps.Parsers]]
deps = ["Dates", "SnoopPrecompile"]
git-tree-sha1 = "6466e524967496866901a78fca3f2e9ea445a559"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.2"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "SnoopPrecompile", "Statistics"]
git-tree-sha1 = "5b7690dd212e026bbab1860016a6601cb077ab66"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.2"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SnoopPrecompile", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "513084afca53c9af3491c94224997768b9af37e8"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "LaTeXStrings", "Markdown", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "96f6db03ab535bdb901300f88335257b0018689d"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.2.2"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["SnoopPrecompile"]
git-tree-sha1 = "18c35ed630d7229c5584b945641a73ca83fb5213"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.2"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase", "SnoopPrecompile"]
git-tree-sha1 = "e974477be88cb5e3040009f3767611bc6357846f"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.11"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "90bc7a7c96410424509e4263e277e43250c05691"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "f94f779c94e58bf9ea243e77a37e16d9de9126bd"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.SnoopPrecompile]]
git-tree-sha1 = "f604441450a3c0569830946e5b33b78c928e1a85"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.1"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "a4ada03f999bd01b3a25dcaa30b2d929fe537e00"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.1.0"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "d75bda01f8c31ebb72df80a46c88b25d1c79c56d"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.1.7"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f9af7f195fb13589dd2e2d57fdb401717d2eb1f6"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.5.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

[[deps.StringManipulation]]
git-tree-sha1 = "46da2434b41f41ac3594ee9816ce5541c6096123"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.3.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "c79322d36826aa2f4fd8ecfa96ddb47b174ac78d"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.10.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "e4bdc63f5c6d62e80eb1c0043fcc0360d5950ff7"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.10"

[[deps.Trapz]]
git-tree-sha1 = "79eb0ed763084a3e7de81fe1838379ac6a23b6a0"
uuid = "592b5752-818d-11e9-1e9a-2b8ca4a44cd1"
version = "2.0.3"

[[deps.URIs]]
git-tree-sha1 = "ac00576f90d8a259f2c9d823e91d1de3fd44d348"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "3e61f0b86f90dacb0bc0e73a0c5a83f6a8636e23"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.19.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "58443b63fb7e465a8a7210828c91c08b92132dff"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.14+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e45044cd873ded54b6a5bac0eb5c971392cf1927"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.2+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "868e669ccb12ba16eaf50cb2957ee2ff61261c56"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.29.0+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9ebfc140cc56e8c2156a15ceac2f0302e327ac0a"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+0"
"""

# ╔═╡ Cell order:
# ╟─5f7c744b-3d62-4856-a90c-a1c4acfbd0cb
# ╟─545b41db-f31f-41ea-bd71-a83e1a9f2d31
# ╠═45191d34-e4ff-4136-8262-c98cffb4254d
# ╠═5ae5790a-33d0-4e90-9082-3e5725eb0df4
# ╠═40ed2e40-16c7-4e44-a9d3-4a8a19b3c156
# ╠═f386507d-8389-4113-addb-51e80585a7b3
# ╠═bf5246a8-d527-4ba9-be6f-8f7a78eb19a7
# ╠═5bbc3ec4-eca9-4a1e-bffd-7bcd0b19c0d9
# ╠═ea79e3dc-31b6-43a7-9d6f-cc0e32dd2227
# ╠═2b4d3141-5f8a-4966-ae70-46488acc8e0d
# ╠═bc7a6764-336a-4791-a003-125e2992a4a0
# ╟─997ee351-e03a-464a-87c4-2ae9ae0defa0
# ╟─38e19ce0-5f2d-484b-b0c0-3a6849d2ac41
# ╟─de9d885e-9d96-46f8-baa4-072649407bf6
# ╟─03dc8bdc-735c-4fd6-a8a9-cef69938bda5
# ╟─0eaa0764-2bec-4296-8bb3-333f2887133b
# ╠═8d161e61-c8bf-48fe-bb9c-585dd0e54c74
# ╟─c66a9db2-f335-467e-b679-0428fe3249ce
# ╟─865b1d0a-0600-40f3-935b-d9f3e35d1332
# ╟─f6fc210a-9ded-4c28-96c0-1fcbc1306a0e
# ╟─54a564ae-49bf-4ac5-9645-ee624b264513
# ╟─6a4bbe1f-34f5-44fd-915c-40ef24b36a1d
# ╟─df32f4bc-b7af-4354-80e0-ba31bcea0d3c
# ╟─84e03f20-8982-48de-89d1-e98de8d298f2
# ╟─bcbf9fe3-12ee-4d9f-b570-f0b181655aa5
# ╟─c5a9ac7a-91ea-4495-ba1f-8998103dddc4
# ╟─4889bb1c-807d-4594-bbb0-dc4934fe264d
# ╟─389de9c7-1fc0-42b7-9050-a8b44585b24d
# ╟─722bf980-27a1-475c-89c4-4956d4dd2e84
# ╟─35425fbf-5007-407b-b89a-41307c57e0c1
# ╟─18309d45-d1c5-42fa-aa02-98ff46b8c467
# ╟─1e43d546-1e02-43c3-8f40-6d7ba37a217a
# ╟─ee9967b7-a28b-4d91-a98a-e04a56408401
# ╟─c7cf5819-5348-4aa7-9543-95398234ad23
# ╟─6fa22920-a9af-40ec-a57d-72f4923af097
# ╟─e6243875-da4a-43bc-ab88-254def5dbc82
# ╟─40e77682-3234-413e-86fb-cb1ebff29b37
# ╟─299d5a9f-1475-4f61-b83e-c87825ccfb5f
# ╟─235a8e84-04fd-451d-a128-80a6562d5f58
# ╟─73b2a22d-5cf4-42bf-a65c-a2085a0577fc
# ╟─e8453875-3323-4e37-a7b5-57f4dfa50e03
# ╟─9993a1d9-2aa5-4b53-81b0-d82a59cfa52d
# ╟─dc4685b5-65d9-43dd-898f-e14c0eb6f126
# ╟─733ad321-5e67-490a-a06a-cd6afce4487e
# ╟─2f608675-1fee-48d0-beaa-6345fa6cf0ba
# ╟─0d74df86-e72d-4cf9-ad2f-b8c5f4495227
# ╟─2ba00a4d-e118-4b01-8b45-8e4315446bda
# ╟─434017ed-e800-4af4-908b-7e5840d781b1
# ╟─96e4f3c8-dd07-4180-9c8a-4fe1c4bf13b9
# ╟─10d3f47b-bf14-4ce1-85b1-4ef7658428c1
# ╟─d829d83a-c80f-4b83-8f30-db206315e1f5
# ╟─46edcd70-646d-4682-918d-fe3516daa84f
# ╟─d71f2545-e40c-4f9c-96d7-c5c2af623f1d
# ╟─8eafc2cb-e5bc-4156-b0cd-91b9bc6923eb
# ╟─1c5f68c1-e47f-4ead-8962-0032684d4f35
# ╟─1d6a20c2-3a0d-41da-a887-68a0af9526b6
# ╟─bc1b3a5c-33ad-433f-9e1d-ffa797fb33a9
# ╟─9029511c-557c-4907-ad5e-03a946ef4326
# ╟─e8f8e518-0b70-4bda-b771-abec4c0077ed
# ╟─b6146d6b-9b89-4076-8f3a-2296c5111450
# ╟─1826d156-9724-430a-b404-1c6a13cc2214
# ╟─ff6347fb-6f98-4175-9cc0-8a91382463af
# ╟─5aba491f-7ebe-481c-a251-e9f65ae771df
# ╟─8c76605d-2cfa-4652-8bed-1b8cf38aa672
# ╟─887540e9-e8f8-4065-9bb3-77d9ae2fb563
# ╟─593aa6be-cab0-4dbb-afd1-c4717d067260
# ╟─ba4c2023-1b5e-4522-b9b5-593b94874857
# ╟─73244f1e-f8b7-4a07-b5f0-6fc1bbeed0e0
# ╟─d94039c9-973c-4e92-a69e-d2a69b989c98
# ╟─d0509f6b-e295-4702-8aec-7dd1f7bdea56
# ╠═26e02b24-7c66-11ed-3992-2db5476f680b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
