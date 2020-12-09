//
// Generated by Microsoft (R) D3DX9 Shader Compiler 9.08.299.0000
//
//   vsa shaderdump19/SLS2064.vso /Fcshaderdump19/SLS2064.vso.dis
//
//
// Parameters:
//
float3 LightDirection[3] : register(c13);
row_major float4x4 ModelViewProj : register(c0);
float4 ShadowProjData : register(c24);
float4 ShadowProjTransform : register(c23);
//
//
// Registers:
//
//   Name                Reg   Size
//   ------------------- ----- ----
//   ModelViewProj[0]       const_0        1
//   ModelViewProj[1]       const_1        1
//   ModelViewProj[2]       const_2        1
//   ModelViewProj[3]       const_3        1
//   LightDirection[0]      const_13       1
//   ShadowProjTransform const_23      1
//   ShadowProjData      const_24      1
//


// Structures:

struct VS_INPUT {
    float4 position : POSITION;
    float4 texcoord_0 : TEXCOORD0;
    float4 texcoord_1 : TEXCOORD1;
    float4 texcoord_2 : TEXCOORD2;
};

struct VS_OUTPUT {
    float4 color_0 : COLOR0;
    float4 color_1 : COLOR1;
    float4 position : POSITION;
    float2 texcoord_0 : TEXCOORD0;
    float2 texcoord_1 : TEXCOORD1;
    float4 texcoord_2 : TEXCOORD2;
    float3 texcoord_3 : TEXCOORD3;
};

// Code:

VS_OUTPUT main(VS_INPUT IN) {
    VS_OUTPUT OUT;

    float2 q0;
    float2 q1;

    q0.xy = ShadowProjTransform.zw - IN.position.xy;
    OUT.color_0.rgba = IN.texcoord_1.xyzw;
    OUT.color_1.rgba = IN.texcoord_2.xyzw;
    OUT.position.xyzw = mul(ModelViewProj, IN.position.xyzw);
    q1.xy = (IN.texcoord_0.xy / 512) + ShadowProjTransform.xy;
    OUT.texcoord_0.xy = q1.xy;
    OUT.texcoord_1.xy = q1.xy;
    OUT.texcoord_2.w = 1 - saturate((ShadowProjData.x - length(q0.xy)) / ShadowProjData.y);
    OUT.texcoord_2.xyz = 1;
    OUT.texcoord_3.xyz = LightDirection[0].xyz;

    return OUT;
};

// approximately 23 instruction slots used
