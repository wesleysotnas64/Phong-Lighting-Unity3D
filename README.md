# Phong-Shading-Unity3D

## 1 - Descrição
Para aqueles que estudam Computação Gráfica e utilizam a Unity3D para desenvolver suas aplicações, estarei disponibilizando aqui um arquivo **.shader** do Unity3D.

O shader disponível é uma simples iluminação baseada no modelo de iluminação de Phong. Nele você pode modificá-lo da maneira que achar melhor e obter os resultados de renderização que você deseja.

Além da explicação, de como funciona a iluminação de Phong, mostro o passo a passo para calcular no Unity3D através de shaders.

Espero que ajude e goste do conteúdo.

## 2 - Como utilizar (Em desenvolvimento...)
Aqui segue o passo a passo para utilizar o **.shader** na Unity3D.

### 2.1 - Preparação do ambiente
- Ao criao o projeto no Unity3D, dê preferência ao 3D (UPR) Core.
- Entre com o nome do projeto e a pasa destino que deseja salvar o projeto.
- Crie o projeto e aguarde alguns minutos até o projeto ser configurado e estar pronto para uso.
- Ao criar o projeto, na sessão de projetos, dentro da pasta **Assets**, crie 2 pastas, para se organizar, uma chamada **Shaders**, onde serão salvos os arquivos .shader, e outra **Materials** onde serão armazenados os materiais, os quais utilizarão os shaders.
- Para finalizar, baixe o arquivo **.shader** disponibilizado no repositório.

![Use Shaders 1](https://user-images.githubusercontent.com/94082665/216823753-807b525c-0bc2-43f6-a656-9543729353e3.png)
![Use Shaders 2](https://user-images.githubusercontent.com/94082665/216823799-e3722a88-a9d5-4c96-865c-61f8b2eef5fb.png)

### 2.2 - Utilizando o Shader
Como ambiente preparado, agora:
- Na pasta **Shaders**, importe o arquivo **.shader**.
- Na pasta **Materials** crie um novo material e aplique o shader.

![Use Shaders 3](https://user-images.githubusercontent.com/94082665/216823828-d5010066-9dba-45a9-bcdb-335c56fd05fb.png)
![Use Shaders 4](https://user-images.githubusercontent.com/94082665/216823837-9b8e0b74-a881-4e09-b1d1-006e196a7836.png)

Agora basta configurar o material a sua preferência e utiliza-lo em um objeto 3D.

![Use Shaders 5](https://user-images.githubusercontent.com/94082665/216823855-dc9d6823-85ce-4c71-a952-b4e917c663cf.png)


## 3 - Modelo de Iluminação de Phong
O modelo de iluminação de Phong (Phong 1973) é o modelo de iluminação provavelmente mais utilizado em computação gráfica hoje em dia. No modelo de Phong, a luz em qualuqer ponto é composta por três componentes: **luz difusa**, **luz especular** e **luz ambiente**. Essas três componentes são aditivas e determinam o aspecto final da iluminação e da cor de um determinado ponto na cena ou da superfície de um determinado polígono plano contido nela.

O modelo não é fisicamente correto e, por exemplo, não respeita a lei de conservação de energia. Entretanto, produz resultantes suficientemente adequados para produzir a percepção de objetos iluminados. Além disso, é muito eficiente.

### 3.1 -  O que é necessário para calcular
Para o cálculo da coloração em um ponto específina na superficie de um objeto, são necessário os seguintes elementos:
- Um ponto **P** na superfície(o qual se deseja calcular sua cor)
- Uma câmera/observador **E** (especificamente o ponto/coordenada deste no espaço)
- Uma fonte de iluminação **L** (que semelhante a câmera necessitamos apenas de sua coordenada)

A partir desses três elementos, podemos extraír outros componente, também importantes e necessários, para o cálculo da iluminação.

*(Os seguintes vetores serão normalizados, logo todos terão tamanho, ou módulo, igual a 1)*
- Vetor normal **n** (do ponto ou sueprfície)
- Vetor visão **v** (obtido através de **E-P**)
- Vetor luz **l** (obtido através de **L-P**)
- Vetor reflexo **r** (obtido através de **2(l.n)n-l**)

![Phong Vetores](https://user-images.githubusercontent.com/94082665/216787969-0eebc60c-9b1e-4d12-a6f5-a5a9caf2b894.png)

### 3.2 - Luz Ambiente
Em ambientes onde **não** há atuação da atmosfera, como na superfície lunar, as superfícieas que não são iluminadas são completamente escuras. Já em ambientes onde há atuação atmosvera, é poissível observar que a luz irradiada de um objeto incide em outros, chamamos isso de iluminação ambiente.

Obtemos a luz ambiente através do seguinte cálculo:

- **Iamb = IA . ramb**
- **Iamb**: Intencidade da luz ambiente da superfície
- **IA**: Intensidade Global da luz ambiente 
- **ramb**: Coeficiente de reflectividade ambiente da superfície

![Phong Dog Ambient](https://user-images.githubusercontent.com/94082665/216786875-25cd2e9c-73a8-4022-a94e-b59b3df24fec.png)


### 3.3 - Luz Difusa
Cada objeto possue características de iluminação difusa que determinam quanta luz é refletida por sua superfície. A quantidade de luz difusa refletida é independente da direção da qual a superfície é vista (observador), uma vez que superfícies que refletem de forma difusa refletem de forma igual em todas as direções. A intensidade da reflecção difusa varia apenas com o cosseno do ângulo entre a normal da superfície e a fonte de luz (**n . l**), que nos indica a quantidade de luz que incide sobre aquele ponto.

Obtemos a luz difusa através do seguinte cálculo:

**Idif = IL . rdif (n.l)**
- **Idif**: Intencidade da luz difusa da superfície
- **IL**: Intensidade da fonte de luz
- **rdif**: Coeficiente de reflectividade difusa da superfície
- **(n.l)**: Produto escalar entre vetor nomal **n** e vetor luz **l**

![Phong Dog Difuse](https://user-images.githubusercontent.com/94082665/216786843-bf3ef01e-2708-42fc-9ebc-334fc3223e5c.png)

### 3.4 - Luz Especular
A componente especular de um objeto simula reflexos extremamente direcionais, sem que a cor dos raios seja afetada pela cor da superfície, **como num espelho**, e nos indica o quão "brilhante" este objeto é. Ela serve para simular a aparência de objetos de superfície muito polida e que refletem a luz sem modificar a sua cor, como objetos metálicos ou objetos esmaltados.

Da mesma forma que nas reflexões difusas, toda superfície possue também um **coeficiente de reflectividade especular** que determina quanta luz é refletida por este objeto. A **intensidade da reflexão especular** é proporcional ao *cosseno do angulo entre a direção de visada e a direção de reflexão da luz*. Além disso existe ainda um **expoente especular**, que determina o quão rápido o reflexo especular decai quando o ângulo de visada se afasta do ângulo de reflexão. Este parâmetro determina o quão locais serão os reflexos e nos permite simular com perfeição a característica dos reflexos de superfícies brilhantes de serem extremamente localizados e restritos.

Obtemos a luz especular através do seguinte cálculo:

**Iespec = IL . respec . (v.r)^s**
- **Iespec**: Intencidade da luz especular da superfície
- **IL**: Intensidade da fonte de luz
- **respec**: Coeficiente de reflectividade especular da superfície
- **(v.r)**: Produto escalar entre vetor visão **v** e vetor reflexo **r**
- **s**: Expoente especular

![Phong Dog Specular](https://user-images.githubusercontent.com/94082665/216786856-b9a9171a-ecfe-4812-849e-fe2d1dee606f.png)

### 3.5 - Modelo completo
O modelo de Phong completo é implementado através da soma das três componentes apresentadas acima:

**I = Iamb + Idif + Iespec**

- I = (IA . ramb) + (IL . rdif (n.l)) + (IL . respec . (v.r)^s)
- I = (IA . ramb) + (IL . ((rdif (n.l)) + (respec . (v.r)^s)))

![Phong Dog All](https://user-images.githubusercontent.com/94082665/216787115-20f38e4b-05d8-4fb5-ac04-b08bb6b1e75b.png)
![Phong Dog](https://user-images.githubusercontent.com/94082665/216791286-ea56e537-3e4a-4901-8554-eec91085e57a.png)


## 4 - Aplicando iluminação no Unity3D através de shaders.

## Referências
- Unity: <https://unity.com>
- Unity Documentation: <https://docs.unity3d.com/Manual/index.html>
- Learn OpenTK: <https://opentk.net/learn/index.html>
- MCTA008-17 Computação Gráfica: <https://www.brunodorta.com.br/cg/>
- Prof. Dr. Aldo Wangenheim: <https://www.inf.ufsc.br/~aldo.vw/grafica/raytracing/iluminacao.html>
- Roystan: <https://roystan.net/>
