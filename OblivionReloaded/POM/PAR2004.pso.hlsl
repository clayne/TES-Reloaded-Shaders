//
// Generated by Microsoft (R) D3DX9 Shader Compiler 9.08.299.0000
//
//   vsa shaderdump19/PAR2004.pso /Fcshaderdump19/PAR2004.pso.dis
//
//
// Parameters:
//
float4 AmbientColor : register(c1);
sampler2D AttenuationMap : register(s5);
sampler2D BaseMap : register(s0);
sampler2D NormalMap : register(s1);
float4 PSLightColor[4] : register(c2);
float4 Toggles : register(c7);
float4 TESR_ShadowCubeData : register(c6);
float4 TESR_ShadowLightPosition[12] : register(c11);
float4 TESR_ShadowCubeMapBlend : register(c8);
float4 TESR_ShadowCubeMapBlend2 : register(c9);
float4 TESR_ShadowCubeMapBlend3 : register(c10);
samplerCUBE TESR_ShadowCubeMapBuffer0 : register(s3) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; ADDRESSW = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };
samplerCUBE TESR_ShadowCubeMapBuffer1 : register(s4) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; ADDRESSW = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };
samplerCUBE TESR_ShadowCubeMapBuffer2 : register(s6) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; ADDRESSW = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };
samplerCUBE TESR_ShadowCubeMapBuffer3 : register(s7) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; ADDRESSW = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };
samplerCUBE TESR_ShadowCubeMapBuffer4 : register(s8) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; ADDRESSW = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };
samplerCUBE TESR_ShadowCubeMapBuffer5 : register(s9) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; ADDRESSW = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };
samplerCUBE TESR_ShadowCubeMapBuffer6 : register(s10) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; ADDRESSW = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };
samplerCUBE TESR_ShadowCubeMapBuffer7 : register(s11) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; ADDRESSW = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };
samplerCUBE TESR_ShadowCubeMapBuffer8 : register(s12) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; ADDRESSW = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };
samplerCUBE TESR_ShadowCubeMapBuffer9 : register(s13) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; ADDRESSW = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };
samplerCUBE TESR_ShadowCubeMapBuffer10 : register(s14) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; ADDRESSW = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };
samplerCUBE TESR_ShadowCubeMapBuffer11 : register(s15) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; ADDRESSW = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };
//
//
// Registers:
//
//   Name           Reg   Size
//   -------------- ----- ----
//   AmbientColor   const_1       1
//   PSLightColor[0]   const_2        1
//   PSLightColor[1]   const_3        1
//   Toggles        const_7       1
//   BaseMap        texture_0       1
//   NormalMap      texture_1       1
//   AttenuationMap texture_5       1
//


// Structures:

struct VS_OUTPUT {
    float2 BaseUV : TEXCOORD0;			// partial precision
    float3 texcoord_1 : TEXCOORD1_centroid;			// partial precision
    float3 texcoord_2 : TEXCOORD2_centroid;			// partial precision
    float4 texcoord_4 : TEXCOORD4;			// partial precision
    float3 texcoord_6 : TEXCOORD6_centroid;    float4 texcoord_7 : TEXCOORD7;			// partial precision
    float3 color_0 : COLOR0;
    float4 color_1 : COLOR1;
};

struct PS_OUTPUT {
    float4 color_0 : COLOR0;
};

// Code:

#include "../Shadows/Includes/ShadowCube.hlsl"

PS_OUTPUT main(VS_OUTPUT IN) {
    PS_OUTPUT OUT;

#define	expand(v)		(((v) - 0.5) / 0.5)
#define	compress(v)		(((v) * 0.5) + 0.5)
#define	uvtile(w)		(((w) * 0.04) - 0.02)
#define	shade(n, l)		max(dot(n, l), 0)
#define	shades(n, l)		saturate(dot(n, l))

    float1 att0;
    float1 att1;
    float3 q3;
    float3 q4;
    float3 q5;
    float3 q7;
    float3 q8;
    float3 q9;
    float4 r0;
    float4 r3;
    float2 uv2;
    float Shadow;

    Shadow = GetLightAmount(IN.texcoord_7);

    r0.xyzw = tex2D(BaseMap, IN.BaseUV.xy);			// partial precision
    att1.x = tex2D(AttenuationMap, IN.texcoord_4.zw);			// partial precision
    att0.x = tex2D(AttenuationMap, IN.texcoord_4.xy);			// partial precision
    uv2.xy = (uvtile(r0.w) * (IN.texcoord_6.xy / length(IN.texcoord_6.xyz))) + IN.BaseUV.xy;
    r3.xyzw = tex2D(NormalMap, uv2.xy);			// partial precision
    r0.xyzw = tex2D(BaseMap, uv2.xy);			// partial precision
    q3.xyz = normalize(expand(r3.xyz));			// partial precision
    q4.xyz = saturate((1 - att0.x) - att1.x) * (shades(q3.xyz, normalize(IN.texcoord_2.xyz)) * PSLightColor[1].rgb);			// partial precision
    q7.xyz = (Toggles.x <= 0.0 ? r0.xyz : (r0.xyz * IN.color_0.rgb));    q7 *= Shadow;			// partial precision
    q5.xyz = ((shades(q3.xyz, IN.texcoord_1.xyz) * PSLightColor[0].rgb) + q4.xyz) + AmbientColor.rgb;			// partial precision
    q8.xyz = max(q5.xyz, 0) * q7.xyz;			// partial precision
    q9.xyz = (Toggles.y <= 0.0 ? q8.xyz : ((IN.color_1.a * (IN.color_1.rgb - (q7.xyz * max(q5.xyz, 0)))) + q8.xyz));			// partial precision
    OUT.color_0.a = AmbientColor.a;			// partial precision
    OUT.color_0.rgb = q9.xyz;			// partial precision

    return OUT;
};

// approximately 37 instruction slots used (5 texture, 32 arithmetic)
