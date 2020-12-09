//
// Generated by Microsoft (R) D3DX9 Shader Compiler 9.08.299.0000
//
//   vsa shaderdump19/GRASS2028.vso /Fcshaderdump19/GRASS2028.vso.dis
//
//
// Parameters:

float3 DiffuseDir : register(c0);
float3 DiffuseColor : register(c1);
float3 ScaleMask : register(c2);
float4 WindData : register(c4);
float4 AlphaParam : register(c5);
float4 AmbientColor : register(c6);
float4 AddlParams : register(c7);
float4 ShadowProjData : register(c8);
row_major float4x4 ModelViewProj : register(c9);
float4 ShadowProjTransform : register(c13);
float4 FogColor : register(c14);
float4 FogParam : register(c15);
float4 InstanceData[228] : register(c20);
float4 TESR_GrassScale : register(c248);
row_major float4x4 TESR_ShadowCameraToLightTransform : register(c249);

// Registers:
//
//   Name                Reg   Size
//   ------------------- ----- ----
//   DiffuseDir          const_0       1
//   DiffuseColor        const_1       1
//   ScaleMask           const_2       1
//   WindData            const_4       1
//   AlphaParam          const_5       1
//   AmbientColor        const_6       1
//   AddlParams          const_7       1
//   ShadowProjData      const_8       1
//   ModelViewProj[0]       const_9        1
//   ModelViewProj[1]       const_10        1
//   ModelViewProj[2]       const_11        1
//   ModelViewProj[3]       const_12        1
//   ShadowProjTransform const_13      1
//   FogColor            const_14      1
//   FogParam            const_15      1
//   InstanceData[0]        const_20       1
//   InstanceData[1]        const_21       1
//


// Structures:

struct VS_INPUT {
    float4 LPOSITION : POSITION;
    float4 LCOLOR_0 : COLOR0;
    float4 LTEXCOORD_0 : TEXCOORD0;
    float4 LTEXCOORD_1 : TEXCOORD1;
};

struct VS_OUTPUT {
    float4 color_0 : COLOR0;
    float4 position : POSITION;
    float2 texcoord_0 : TEXCOORD0;
    float3 texcoord_4 : TEXCOORD4;
    float4 texcoord_5 : TEXCOORD5;
	float4 texcoord_6 : TEXCOORD6;
};

// Code:

VS_OUTPUT main(VS_INPUT IN) {
    VS_OUTPUT OUT;

#define	PI				3.14159274
#define	anglei(v)		(((v) + PI) / (2 * PI))
#define	angler(v)		(((v) * (2 * PI)) - PI)
#define	fracr(v)		angler(frac(anglei(v)))	// signed modulo % PI
#define	expand(v)		(((v) - 0.5) / 0.5)
#define	shades(n, l)	saturate(dot(n, l))
#define	sqr(v)			((v) * (v))

    const float4 const_3 = {-0.5, 0.01, 1, (1.0 / 17)};

    float1 q0;
    float4 r0;
    float4 r1;
    float3 r2;

    r0.yz = const_3.yz;
    q0.x = InstanceData[0 + IN.LTEXCOORD_1.x].y + InstanceData[0 + IN.LTEXCOORD_1.x].x;
    r0.x = expand(frac(q0.x / 17));
    r0.w = sqrt(1.0 - sqr(r0.x));
    r1.w = IN.LPOSITION.w;
    OUT.color_0.rgb = FogColor.rgb;
    OUT.texcoord_0.xy = IN.LTEXCOORD_0.xy;
    r1.xyz = (((r0.y * InstanceData[0 + IN.LTEXCOORD_1.x].w) * ScaleMask.xyz) + r0.z) * IN.LPOSITION.xyz;
    r0.z = 0;
    r0.y = -r0.w;
    r2.y = dot(r0.wxz, r1.xyz);
    r2.x = dot(r0.xyz, r1.xyz);
    r0.z = r1.z;
    r0.xy = (((sin(fracr((q0.x / 128) + WindData.w)) * WindData.z) * sqr(IN.LCOLOR_0.w)) * WindData.xy) + r2.xy;
    r1.xyz = r0.xyz + InstanceData[0 + IN.LTEXCOORD_1.x].xyz;
    r0.xyzw = frac(InstanceData[0 + IN.LTEXCOORD_1.x]);
    r2.xyz = ((r0.w * IN.LCOLOR_0.xyz) * shades(DiffuseDir.xyz, expand(r0.xyz))) * DiffuseColor.rgb;
    r0 = mul(ModelViewProj, r1);
    r1.xy = saturate((length(r0.xyzw) - AlphaParam.xz) / AlphaParam.yw);
    OUT.color_0.a = 1 - saturate((FogParam.x - length(r0.xyz)) / FogParam.y);
    OUT.position = r0;
    OUT.texcoord_4.xyz = AmbientColor.rgb;
    OUT.texcoord_5.w = r1.x * (1 - r1.y);
    OUT.texcoord_5.xyz = r2.xyz * AddlParams.x;
	OUT.texcoord_6 = mul(r0, TESR_ShadowCameraToLightTransform);
	
    return OUT;
};

// approximately 85 instruction slots used