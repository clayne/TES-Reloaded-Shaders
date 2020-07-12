//
// Generated by Microsoft (R) D3DX9 Shader Compiler 9.08.299.0000
//
//   vsa shaderdump19/STB2007.vso /Fcshaderdump19/STB2007.vso.dis
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
float4 WindMatrices[16] : register(c38);
row_major float4x4 TESR_ShadowCameraToLightTransform : register(c54);

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
//   WindMatrices[0]        const_38      4
//   WindMatrices[1]        const_39      4
//   WindMatrices[2]        const_40      4
//   WindMatrices[3]        const_41      4
//


// Structures:

struct VS_INPUT {
    float4 LPOSITION : POSITION;
    float3 LTANGENT : TANGENT;
    float3 LBINORMAL : BINORMAL;
    float3 LNORMAL : NORMAL;
    float4 LTEXCOORD_0 : TEXCOORD0;
    float4 LBLENDINDICES : BLENDINDICES;
};

struct VS_OUTPUT {
    float4 color_0 : COLOR0;
    float4 color_1 : COLOR1;
    float4 position : POSITION;
    float2 texcoord_0 : TEXCOORD0;
    float3 texcoord_1 : TEXCOORD1;
    float3 texcoord_2 : TEXCOORD2;
    float4 texcoord_4 : TEXCOORD4;
    float4 texcoord_7 : TEXCOORD7;
};

// Code:

VS_OUTPUT main(VS_INPUT IN) {
    VS_OUTPUT OUT;

#define	expand(v)		(((v) - 0.5) / 0.5)
#define	compress(v)		(((v) * 0.5) + 0.5)

    const float4 const_4 = {0.5, 1, 0, 0};

    float3 lit1;
    float4 m32;
    float4 mdl18;
    float1 q0;
    float3 q19;
    float4 q5;
    float4 r0;

    q19.xyz = mul(float3x3(IN.LTANGENT.xyz, IN.LBINORMAL.xyz, IN.LNORMAL.xyz), LightDirection[0].xyz);
    q0.x = IN.LBLENDINDICES.y;
    q5.xyzw = mul(float4x4(WindMatrices[0 + q0.x].xyzw, WindMatrices[1 + q0.x].xyzw, WindMatrices[2 + q0.x].xyzw, WindMatrices[3 + q0.x].xyzw), IN.LPOSITION.xyzw);
    OUT.color_0.rgba = (IN.LBLENDINDICES.z * const_4.yyyz) + const_4.zzzy;
    r0.xyzw = (IN.LBLENDINDICES.x * (q5.xyzw - IN.LPOSITION.xyzw)) + IN.LPOSITION.xyzw;
    mdl18 = mul(ModelViewProj, r0.xyzw);
    m32 = mul(mdl18, TESR_ShadowCameraToLightTransform);
    lit1.xyz = LightPosition[1].xyz - r0.xyz;
    OUT.color_1.rgb = FogColor.rgb;
    OUT.color_1.a = 1 - saturate((FogParam.x - length(mdl18.xyz)) / FogParam.y);
    OUT.position = mdl18;
    OUT.texcoord_0.xy = IN.LTEXCOORD_0.xy;
    OUT.texcoord_1.xyz = normalize(q19.xyz);
    OUT.texcoord_2.xyz = mul(float3x3(IN.LTANGENT.xyz, IN.LBINORMAL.xyz, IN.LNORMAL.xyz), normalize(lit1.xyz));
    OUT.texcoord_4.w = 0.5;
    OUT.texcoord_4.xyz = compress(lit1.xyz / LightPosition[1].w);	// [-1,+1] to [0,1]
    OUT.texcoord_7 = m32;

    return OUT;
};

// approximately 55 instruction slots used