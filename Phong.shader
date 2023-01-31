Shader "Unlit/Phong"
{
    Properties
    {
        _Albedo("Albedo", Color) = (1.0, 1.0, 1.0, 1.0)
        _AmbientStrength("Ambient Strength", Range(0,1)) = 0.1
        _SpecularStrength("Specular Strength", Range(0,1)) = 0.5
        _Shininess("Shininess", Range(0,256)) = 32
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Lighting.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex     : SV_POSITION;
                float3 worldNormal: TEXCOORD0;
                float3 worldView  : TEXCOORD1;
            };

            float4 _Albedo;
            float  _AmbientStrength;
            float  _SpecularStrength;
            int    _Shininess;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldView = UnityObjectToViewPos(v.vertex);

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //Propriedades Externas
                float3 objectColor = _Albedo.xyz;
                float3 ligthColor  = _LightColor0.xyz; // #include "Lighting.cginc"

                //Vetores
                float3 viewDirection   = normalize(i.worldView);
                float3 normalDirection = normalize(i.worldNormal);
                float3 ligthDirection  = normalize(_WorldSpaceLightPos0.xyz);
                float3 reflectDirection = normalize(reflect(-ligthDirection, normalDirection));

                //Calculando iluminação ambiente
                float ambientStrength =_AmbientStrength; 
                float3 ambient = ambientStrength * ligthColor;

                //Calculando iluminação difusa
                float diff = dot
                (
                    normalDirection,
                    ligthDirection
                );

                diff = max(diff, 0.0);
                float3 difuse = diff * ligthColor;

                //Calculando iluminação especular (reflexo)
                float specularStrength = _SpecularStrength;
                float spec = pow(max(dot(viewDirection, reflectDirection), 0.0), _Shininess);
                float3 specular = specularStrength * spec * ligthColor;
                
                //Cor final
                float3 finalColor = (ambient + difuse + specular) * objectColor;

                return fixed4(finalColor, 1.0);
            }
            ENDCG
        }
    }
}
