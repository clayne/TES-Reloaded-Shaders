//
// Generated by Microsoft (R) D3DX9 Shader Compiler 9.08.299.0000
//
//   vsa shaderdump19/SKIN2009.vso /Fcshaderdump19/SKIN2009.vso.dis
//
//
// Parameters:
//
float4 Bones[54] : register(c42);
float4 EyePosition : register(c25);
float3 LightDirection[3] : register(c13);
float4 LightPosition[3] : register(c16);
row_major float4x4 SkinModelViewProj : register(c1);
//
//
// Registers:
//
//   Name              Reg   Size
//   ----------------- ----- ----
//   SkinModelViewProj[0] const_1        1
//   SkinModelViewProj[1] const_2        1
//   SkinModelViewProj[2] const_3        1
//   SkinModelViewProj[3] const_4        1
//   LightDirection[0]    const_13       1
//   LightPosition[0]     const_16       1
//   LightPosition[1]     const_17       1
//   EyePosition       const_25      1
//   Bones[0]             const_42      18
//   Bones[1]             const_43      18
//   Bones[2]             const_44      18
//


// Structures:

struct VS_INPUT {
    float4 Position : POSITION;
    float3 tangent : TANGENT;
    float3 binormal : BINORMAL;
    float3 normal : NORMAL;
    float4 BaseUV : TEXCOORD0;
    float3 blendweight : BLENDWEIGHT;
    float4 blendindices : BLENDINDICES;
};

struct VS_OUTPUT {
    float4 Position : POSITION;
    float2 BaseUV : TEXCOORD0;
    float3 Light0Dir : TEXCOORD1;
    float3 Light1Dir : TEXCOORD2;
    float4 Att1UV : TEXCOORD4;
    float3 CameraDir : TEXCOORD7;
};

// Code:

VS_OUTPUT main(VS_INPUT IN) {
    VS_OUTPUT OUT;

#define	expand(v)		(((v) - 0.5) / 0.5)
#define	compress(v)		(((v) * 0.5) + 0.5)
#define	weight(v)		dot(v, 1)
#define	sqr(v)			((v) * (v))

    const float4 const_0 = {1, 765.01001, 0, 0.5};

    float3 eye42;
    float3 lit3;
    float3 m40;
    float4 offset;
    float1 q0;
    float4 q1;
    float3 q17;
    float3 q18;
    float3 q19;
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
    float3 q39;
    float4 r0;

    offset.xyzw = IN.blendindices.zyxw * 765.01001;
    q26.xyz = mul(float3x3(Bones[0 + offset.w].xyz, Bones[1 + offset.w].xyz, Bones[2 + offset.w].xyz), IN.tangent.xyz);
    q24.xyz = mul(float3x3(Bones[0 + offset.z].xyz, Bones[1 + offset.z].xyz, Bones[2 + offset.z].xyz), IN.tangent.xyz);
    q23.xyz = mul(float3x3(Bones[0 + offset.x].xyz, Bones[1 + offset.x].xyz, Bones[2 + offset.x].xyz), IN.tangent.xyz);
    q22.xyz = mul(float3x3(Bones[0 + offset.y].xyz, Bones[1 + offset.y].xyz, Bones[2 + offset.y].xyz), IN.tangent.xyz);
    q38.xyz = mul(float3x3(Bones[0 + offset.w].xyz, Bones[1 + offset.w].xyz, Bones[2 + offset.w].xyz), IN.normal.xyz);
    q36.xyz = mul(float3x3(Bones[0 + offset.z].xyz, Bones[1 + offset.z].xyz, Bones[2 + offset.z].xyz), IN.normal.xyz);
    q35.xyz = mul(float3x3(Bones[0 + offset.x].xyz, Bones[1 + offset.x].xyz, Bones[2 + offset.x].xyz), IN.normal.xyz);
    q34.xyz = mul(float3x3(Bones[0 + offset.y].xyz, Bones[1 + offset.y].xyz, Bones[2 + offset.y].xyz), IN.normal.xyz);
    q32.xyz = mul(float3x3(Bones[0 + offset.w].xyz, Bones[1 + offset.w].xyz, Bones[2 + offset.w].xyz), IN.binormal.xyz);
    q30.xyz = mul(float3x3(Bones[0 + offset.z].xyz, Bones[1 + offset.z].xyz, Bones[2 + offset.z].xyz), IN.binormal.xyz);
    q29.xyz = mul(float3x3(Bones[0 + offset.x].xyz, Bones[1 + offset.x].xyz, Bones[2 + offset.x].xyz), IN.binormal.xyz);
    q28.xyz = mul(float3x3(Bones[0 + offset.y].xyz, Bones[1 + offset.y].xyz, Bones[2 + offset.y].xyz), IN.binormal.xyz);
    q0.x = 1 - weight(IN.blendweight.xyz);
    r0.w = 1;
    q1.xyzw = (IN.Position.xyzx * const_0.xxxz) + const_0.zzzx;
    q21.xyz = mul(float3x4(Bones[0 + offset.w].xyzw, Bones[1 + offset.w].xyzw, Bones[2 + offset.w].xyzw), q1.xyzw);
    q19.xyz = mul(float3x4(Bones[0 + offset.z].xyzw, Bones[1 + offset.z].xyzw, Bones[2 + offset.z].xyzw), q1.xyzw);
    q18.xyz = mul(float3x4(Bones[0 + offset.x].xyzw, Bones[1 + offset.x].xyzw, Bones[2 + offset.x].xyzw), q1.xyzw);
    q17.xyz = mul(float3x4(Bones[0 + offset.y].xyzw, Bones[1 + offset.y].xyzw, Bones[2 + offset.y].xyzw), q1.xyzw);
    q37.xyz = (IN.blendweight.z * q36.xyz) + ((IN.blendweight.x * q35.xyz) + (q34.xyz * IN.blendweight.y));
    q39.xyz = normalize((q0.x * q38.xyz) + q37.xyz);
    q31.xyz = (IN.blendweight.z * q30.xyz) + ((IN.blendweight.x * q29.xyz) + (q28.xyz * IN.blendweight.y));
    q33.xyz = normalize((q0.x * q32.xyz) + q31.xyz);
    q25.xyz = (IN.blendweight.z * q24.xyz) + ((IN.blendweight.x * q23.xyz) + (q22.xyz * IN.blendweight.y));
    q27.xyz = normalize((q0.x * q26.xyz) + q25.xyz);
    m40.xyz = mul(float3x3(q27.xyz, q33.xyz, q39.xyz), LightDirection[0].xyz);
    q20.xyz = (IN.blendweight.z * q19.xyz) + ((IN.blendweight.x * q18.xyz) + (q17.xyz * IN.blendweight.y));
    r0.xyz = (q0.x * q21.xyz) + q20.xyz;
    eye42.xyz = mul(float3x3(q27.xyz, q33.xyz, q39.xyz), normalize(EyePosition.xyz - r0.xyz));
    OUT.Position.xyzw = mul(SkinModelViewProj, r0.xyzw);
    lit3.xyz = LightPosition[1].xyz - r0.xyz;
    OUT.BaseUV.xy = IN.BaseUV.xy;
    OUT.Light0Dir.xyz = normalize(m40.xyz);
    OUT.Light1Dir.xyz = mul(float3x3(q27.xyz, q33.xyz, q39.xyz), normalize(lit3.xyz));
    OUT.Att1UV.w = 0.5;
    OUT.Att1UV.xyz = compress(lit3.xyz / LightPosition[1].w);
    OUT.CameraDir.xyz = normalize(eye42.xyz);

    return OUT;
};

// approximately 115 instruction slots used