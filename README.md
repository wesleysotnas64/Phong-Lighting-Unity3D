# Phong-Shading-Unity3D

## 1 - Descrição
Para aqueles que estudam Computação Gráfica e utilizam a Unity3D para desenvolver suas aplicações, estarei disponibilizando aqui um arquivo **.shader** do Unity3D.

O shader disponível é uma simples iluminação baseada no modelo de iluminação de Phong. Nele você pode modificá-lo da maneira que achar melhor e obter os resultados de renderização que você deseja.

## 2 - Como utilizar (Em desenvolvimento...)
Aqui segue o passo a passo para utilizar o **.shader** na Unity3D.

### 2.1 - Preparação do ambiente

### 2.2 - Utilizando o Shader

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

*Imagem para ilustrar os vetores e os pontos...*

### 3.2 - Luz Ambiente
Em ambientes onde **não** há atuação da atmosfera, como na superfície lunar, as superfícieas que não são iluminadas são completamente escuras. Já em ambientes onde há atuação atmosvera, é poissível observar que a luz irradiada de um objeto incide em outros, chamamos isso de iluminação ambiente.

*Imagem exemplo iluminação com e sem luz ambiente*




## Referências
- Unity: <https://unity.com>
- Unity Documentation: <https://docs.unity3d.com/Manual/index.html>
- Learn OpenTK: <https://opentk.net/learn/index.html>
