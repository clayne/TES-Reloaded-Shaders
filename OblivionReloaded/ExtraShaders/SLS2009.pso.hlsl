//
// Generated by Microsoft (R) D3DX9 Shader Compiler 9.08.299.0000
//
//   vsa shaderdump19/SLS2009.pso /Fcshaderdump19/SLS2009.pso.dis
//
//
// Parameters:

float4 AmbientColor : register(c1);
float4 PSLightColor[4] : register(c2);
float4 Toggles : register(c7);
float4 TESR_ShadowData : register(c8);
float4 TESR_ShadowLightPosition[4] : register(c9);
float4 TESR_ShadowCubeMapFarPlanes : register(c13);

sampler2D BaseMap : register(s0);
sampler2D NormalMap : register(s1);
sampler2D AttenuationMap : register(s5);
samplerCUBE TESR_ShadowCubeMapBuffer0 : register(s8) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; ADDRESSW = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };

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
    float2 BaseUV : TEXCOORD0;
    float3 texcoord_1 : TEXCOORD1_centroid;
    float3 texcoord_2 : TEXCOORD2_centroid;
    float4 texcoord_4 : TEXCOORD4;
	float4 texcoord_7 : TEXCOORD7;
    float3 LCOLOR_0 : COLOR0;
    float4 LCOLOR_1 : COLOR1;
};

struct PS_OUTPUT {
    float4 color_0 : COLOR0;
};

#include "../Shadows/Includes/ShadowCube.hlsl"

PS_OUTPUT main(VS_OUTPUT IN) {
	
    PS_OUTPUT OUT;

#define	expand(v)		(((v) - 0.5) / 0.5)
#define	compress(v)		(((v) * 0.5) + 0.5)
#define	shade(n, l)		max(dot(n, l), 0)
#define	shades(n, l)		saturate(dot(n, l))

    float1 att1;
    float1 att2;
    float3 q0;
    float3 q3;
    float3 q4;
    float3 q6;
    float3 q7;
    float3 q8;
    float4 r0;
    float4 r3;
	float3 r4;
	float Shadow;
	
    r3.xyzw = tex2D(NormalMap, IN.BaseUV.xy);
    r0.xyzw = tex2D(BaseMap, IN.BaseUV.xy);
    att2.x = tex2D(AttenuationMap, IN.texcoord_4.zw).x;
    att1.x = tex2D(AttenuationMap, IN.texcoord_4.xy).x;
    q0.xyz = normalize(expand(r3.xyz));
    q3.xyz = saturate((1 - att1.x) - att2.x) * (shades(q0.xyz, normalize(IN.texcoord_2.xyz)) * PSLightColor[1].rgb);
    q6.xyz = (Toggles.x <= 0.0 ? r0.xyz : (r0.xyz * IN.LCOLOR_0.xyz));
	r4.xyz = shades(q0.xyz, IN.texcoord_1.xyz) * PSLightColor[0].rgb;
	Shadow = GetLightAmount(TESR_ShadowCubeMapBuffer0, IN.texcoord_7, TESR_ShadowLightPosition[0], TESR_ShadowCubeMapFarPlanes.x);
    q4.xyz = Shadow * max(r4.xyz + q3.xyz + AmbientColor.rgb, 0);
    q7.xyz = q4.xyz * q6.xyz;
    q8.xyz = (Toggles.y <= 0.0 ? q7.xyz : ((IN.LCOLOR_1.w * (IN.LCOLOR_1.xyz - (q6.xyz * q4.xyz))) + q7.xyz));
    OUT.color_0.a = r0.w * AmbientColor.a;
    OUT.color_0.rgb = q8.xyz;
    return OUT;
	
};

// approximately 31 instruction slots used (4 texture, 27 arithmetic)