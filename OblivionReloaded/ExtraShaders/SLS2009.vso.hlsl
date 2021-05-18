//
// Generated by Microsoft (R) D3DX9 Shader Compiler 9.08.299.0000
//
//   vsa shaderdump19/SLS2009.vso /Fcshaderdump19/SLS2009.vso.dis
//
//
// Parameters:

float3 FogColor : register(c24);
float4 FogParam : register(c23);
float3 LightDirection[3] : register(c13);
float4 LightPosition[3] : register(c16);
row_major float4x4 ModelViewProj : register(c0);
row_major float4x4 ShadowProj : register(c28);
float4 ShadowProjData : register(c32);
float4 ShadowProjTransform : register(c33);
row_major float4x4 TESR_ShadowCameraToLightTransform[2] : register(c34);
row_major float4x4 TESR_InvViewProjectionTransform : register(c50);

// Registers:
//
//   Name                Reg   Size
//   ------------------- ----- ----
//   ModelViewProj[0]       const_0        1
//   ModelViewProj[1]       const_1        1
//   ModelViewProj[2]       const_2        1
//   ModelViewProj[3]       const_3        1
//   LightDirection[0]      const_13       1
//   LightPosition[0]       const_16       1
//   LightPosition[1]       const_17       1
//   FogParam            const_23      1
//   FogColor            const_24      1
//   ShadowProj[0]          const_28       1
//   ShadowProj[1]          const_29       1
//   ShadowProj[2]          const_30       1
//   ShadowProj[3]          const_31       1
//   ShadowProjData      const_32      1
//   ShadowProjTransform const_33      1
//


// Structures:

struct VS_INPUT {
    float4 LPOSITION : POSITION;
    float3 LTANGENT : TANGENT;
    float3 LBINORMAL : BINORMAL;
    float3 LNORMAL : NORMAL;
    float4 LTEXCOORD_0 : TEXCOORD0;
    float4 LCOLOR_0 : COLOR0;
};

struct VS_OUTPUT {
    float4 color_0 : COLOR0;
    float4 color_1 : COLOR1;
    float4 position : POSITION;
    float2 texcoord_0 : TEXCOORD0;
    float3 texcoord_1 : TEXCOORD1;
    float3 texcoord_2 : TEXCOORD2;
    float4 texcoord_4 : TEXCOORD4;
	float4 texcoord_6 : TEXCOORD6;
    float4 texcoord_7 : TEXCOORD7;
    float4 texcoord_8 : TEXCOORD8;
};

// Code:

VS_OUTPUT main(VS_INPUT IN) {
    VS_OUTPUT OUT;

#define	expand(v)		(((v) - 0.5) / 0.5)
#define	compress(v)		(((v) * 0.5) + 0.5)

    float3 lit0;
    float3 q12;
    float4 r0;

    q12.xyz = mul(float3x3(IN.LTANGENT.xyz, IN.LBINORMAL.xyz, IN.LNORMAL.xyz), LightDirection[0].xyz);
    r0 = mul(ModelViewProj, IN.LPOSITION.xyzw);
    lit0.xyz = LightPosition[1].xyz - IN.LPOSITION.xyz;
    OUT.color_0.rgba = IN.LCOLOR_0.xyzw;
    OUT.color_1.a = 1 - saturate((FogParam.x - length(r0.xyz)) / FogParam.y);
    OUT.color_1.rgb = FogColor.rgb;
    OUT.position = r0;
    OUT.texcoord_0.xy = IN.LTEXCOORD_0.xy;
    OUT.texcoord_1.xyz = normalize(q12.xyz);
    OUT.texcoord_2.xyz = mul(float3x3(IN.LTANGENT.xyz, IN.LBINORMAL.xyz, IN.LNORMAL.xyz), normalize(lit0.xyz));
    OUT.texcoord_4.w = 0.5;
    OUT.texcoord_4.xyz = compress(lit0.xyz / LightPosition[1].w);	// [-1,+1] to [0,1]
    OUT.texcoord_6 = mul(r0, TESR_ShadowCameraToLightTransform[0]);
	OUT.texcoord_7 = mul(r0, TESR_ShadowCameraToLightTransform[1]);
    OUT.texcoord_8 = mul(r0, TESR_InvViewProjectionTransform);

    return OUT;
};

// approximately 45 instruction slots used
