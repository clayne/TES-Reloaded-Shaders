//
// Generated by Microsoft (R) D3DX9 Shader Compiler 9.08.299.0000
//
//   vsa shaderdump19/SKIN2003.vso /Fcshaderdump19/SKIN2003.vso.dis
//
//
// Parameters:
//
float4 Bones[54] : register(c42);
float4 EyePosition : register(c25);
float3 FogColor : register(c24);
float4 FogParam : register(c23);
float3 LightDirection[3] : register(c13);
row_major float4x4 ShadowProj : register(c28);
float4 ShadowProjData : register(c32);
float4 ShadowProjTransform : register(c33);
row_major float4x4 SkinModelViewProj : register(c1);

row_major float4x4 TESR_ShadowCameraToLightTransform[2] : register(c34);
row_major float4x4 TESR_InvViewProjectionTransform : register(c97);
row_major float4x4 TESR_ShadowCameraToLightTransformSkin : register(c101);
//
//
// Registers:
//
//   Name                Reg   Size
//   ------------------- ----- ----
//   SkinModelViewProj[0]   const_1        1
//   SkinModelViewProj[1]   const_2        1
//   SkinModelViewProj[2]   const_3        1
//   SkinModelViewProj[3]   const_4        1
//   LightDirection[0]      const_13       1
//   FogParam            const_23      1
//   FogColor            const_24      1
//   EyePosition         const_25      1
//   ShadowProj[0]          const_28       1
//   ShadowProj[1]          const_29       1
//   ShadowProj[2]          const_30       1
//   ShadowProj[3]          const_31       1
//   ShadowProjData      const_32      1
//   ShadowProjTransform const_33      1
//   Bones[0]               const_42      18
//   Bones[1]               const_43      18
//   Bones[2]               const_44      18
//


// Structures:

struct VS_INPUT {
    float4 position : POSITION;
    float3 tangent : TANGENT;
    float3 binormal : BINORMAL;
    float3 normal : NORMAL;
    float4 texcoord_0 : TEXCOORD0;
    float4 color_0 : COLOR0;
    float3 blendweight : BLENDWEIGHT;
    float4 blendindices : BLENDINDICES;
};

struct VS_OUTPUT {
    float4 color_0 : COLOR0;
    float4 color_1 : COLOR1;
    float4 position : POSITION;
    float2 texcoord_0 : TEXCOORD0;
    float3 texcoord_1 : TEXCOORD1;
    float4 texcoord_5 : TEXCOORD5; //Shadow Near
    float3 texcoord_6 : TEXCOORD6;
    float4 texcoord_7 : TEXCOORD7; //Shadow Far
    float4 texcoord_8 : TEXCOORD8; //Inverse pos
};

// Code:

VS_OUTPUT main(VS_INPUT IN) {
    VS_OUTPUT OUT;

#define	weight(v)		dot(v, 1)
#define	sqr(v)			((v) * (v))

    const float4 const_0 = { 1, 765.01001, 0, 0 };

    float3 eye40;
    float3 m91;
    float2 m97;
    float3 mdl41;
    float4 offset;
    float1 q0;
    float4 q1;
    float3 q16;
    float3 q17;
    float3 q18;
    float3 q19;
    float1 q2;
    float3 q20;
    float3 q21;
    float3 q22;
    float3 q23;
    float3 q24;
    float3 q25;
    float3 q26;
    float3 q27;
    float3 q28;
    float3 q29;
    float3 q30;
    float3 q31;
    float3 q32;
    float3 q33;
    float3 q34;
    float3 q35;
    float3 q36;
    float3 q37;
    float3 q38;
    float4 r0;

    OUT.color_0.rgba = IN.color_0.rgba;
    offset.xyzw = IN.blendindices.zyxw * 765.01001;
    q25.xyz = mul(float3x3(Bones[0 + offset.w].xyz, Bones[1 + offset.w].xyz, Bones[2 + offset.w].xyz), IN.tangent.xyz);
    q23.xyz = mul(float3x3(Bones[0 + offset.z].xyz, Bones[1 + offset.z].xyz, Bones[2 + offset.z].xyz), IN.tangent.xyz);
    q22.xyz = mul(float3x3(Bones[0 + offset.x].xyz, Bones[1 + offset.x].xyz, Bones[2 + offset.x].xyz), IN.tangent.xyz);
    q21.xyz = mul(float3x3(Bones[0 + offset.y].xyz, Bones[1 + offset.y].xyz, Bones[2 + offset.y].xyz), IN.tangent.xyz);
    q37.xyz = mul(float3x3(Bones[0 + offset.w].xyz, Bones[1 + offset.w].xyz, Bones[2 + offset.w].xyz), IN.normal.xyz);
    q35.xyz = mul(float3x3(Bones[0 + offset.z].xyz, Bones[1 + offset.z].xyz, Bones[2 + offset.z].xyz), IN.normal.xyz);
    q34.xyz = mul(float3x3(Bones[0 + offset.x].xyz, Bones[1 + offset.x].xyz, Bones[2 + offset.x].xyz), IN.normal.xyz);
    q33.xyz = mul(float3x3(Bones[0 + offset.y].xyz, Bones[1 + offset.y].xyz, Bones[2 + offset.y].xyz), IN.normal.xyz);
    q31.xyz = mul(float3x3(Bones[0 + offset.w].xyz, Bones[1 + offset.w].xyz, Bones[2 + offset.w].xyz), IN.binormal.xyz);
    q29.xyz = mul(float3x3(Bones[0 + offset.z].xyz, Bones[1 + offset.z].xyz, Bones[2 + offset.z].xyz), IN.binormal.xyz);
    q28.xyz = mul(float3x3(Bones[0 + offset.x].xyz, Bones[1 + offset.x].xyz, Bones[2 + offset.x].xyz), IN.binormal.xyz);
    q27.xyz = mul(float3x3(Bones[0 + offset.y].xyz, Bones[1 + offset.y].xyz, Bones[2 + offset.y].xyz), IN.binormal.xyz);
    q0.x = 1 - weight(IN.blendweight.xyz);
    r0.w = 1;
    q1.xyzw = (IN.position.xyzx * const_0.xxxz) + const_0.zzzx;
    q20.xyz = mul(float3x4(Bones[0 + offset.w].xyzw, Bones[1 + offset.w].xyzw, Bones[2 + offset.w].xyzw), q1.xyzw);
    q18.xyz = mul(float3x4(Bones[0 + offset.z].xyzw, Bones[1 + offset.z].xyzw, Bones[2 + offset.z].xyzw), q1.xyzw);
    q17.xyz = mul(float3x4(Bones[0 + offset.x].xyzw, Bones[1 + offset.x].xyzw, Bones[2 + offset.x].xyzw), q1.xyzw);
    q16.xyz = mul(float3x4(Bones[0 + offset.y].xyzw, Bones[1 + offset.y].xyzw, Bones[2 + offset.y].xyzw), q1.xyzw);
    q36.xyz = (IN.blendweight.z * q35.xyz) + ((IN.blendweight.x * q34.xyz) + (q33.xyz * IN.blendweight.y));
    q38.xyz = normalize((q0.x * q37.xyz) + q36.xyz);
    q30.xyz = (IN.blendweight.z * q29.xyz) + ((IN.blendweight.x * q28.xyz) + (q27.xyz * IN.blendweight.y));
    q32.xyz = normalize((q0.x * q31.xyz) + q30.xyz);
    q24.xyz = (IN.blendweight.z * q23.xyz) + ((IN.blendweight.x * q22.xyz) + (q21.xyz * IN.blendweight.y));
    q26.xyz = normalize((q0.x * q25.xyz) + q24.xyz);
    m91.xyz = mul(float3x3(q26.xyz, q32.xyz, q38.xyz), LightDirection[0].xyz);
    q19.xyz = (IN.blendweight.z * q18.xyz) + ((IN.blendweight.x * q17.xyz) + (q16.xyz * IN.blendweight.y));
    r0.xyz = (q0.x * q20.xyz) + q19.xyz;
    mdl41.xyz = mul(float3x4(SkinModelViewProj[0].xyzw, SkinModelViewProj[1].xyzw, SkinModelViewProj[2].xyzw), r0.xyzw);
    eye40.xyz = mul(float3x3(q26.xyz, q32.xyz, q38.xyz), normalize(EyePosition.xyz - r0.xyz));
    OUT.color_1.rgb = FogColor.rgb;
    OUT.color_1.a = 1 - saturate((FogParam.x - length(mdl41.xyz)) / FogParam.y);
    OUT.position.w = dot(SkinModelViewProj[3].xyzw, r0.xyzw);
    OUT.position.xyz = mdl41.xyz;
    OUT.texcoord_0.xy = IN.texcoord_0.xy;
    OUT.texcoord_1.xyz = normalize(m91.xyz);
    OUT.texcoord_6.xyz = normalize(eye40.xyz);
    OUT.texcoord_7 = mul(OUT.position, TESR_ShadowCameraToLightTransform[0]);
    OUT.texcoord_5 = mul(OUT.position, TESR_ShadowCameraToLightTransformSkin);
    OUT.texcoord_8 = mul(OUT.position, TESR_InvViewProjectionTransform);

    return OUT;
};

// approximately 127 instruction slots used
