// Image space shadows shader for Oblivion Reloaded

float4x4 TESR_WorldTransform;
float4x4 TESR_WorldViewProjectionTransform;
float4x4 TESR_ViewTransform;
float4x4 TESR_ProjectionTransform;
float4x4 TESR_ShadowCameraToLightTransformNear;
float4x4 TESR_ShadowCameraToLightTransformFar;
float4 TESR_CameraPosition;
float4 TESR_WaterSettings;
float4 TESR_ShadowData;
float4 TESR_ShadowLightPosition0;
float4 TESR_ShadowLightPosition1;
float4 TESR_ShadowLightPosition2;
float4 TESR_ShadowLightPosition3;
float4 TESR_ShadowLightPosition4;
float4 TESR_ShadowLightPosition5;
float4 TESR_ShadowLightPosition6;
float4 TESR_ShadowLightPosition7;
float4 TESR_ShadowLightPosition8;
float4 TESR_ShadowLightPosition9;
float4 TESR_ShadowLightPosition10;
float4 TESR_ShadowLightPosition11;
float4 TESR_ShadowCullLightPosition0;
float4 TESR_ShadowCullLightPosition1;
float4 TESR_ShadowCullLightPosition2;
float4 TESR_ShadowCullLightPosition3;
float4 TESR_ShadowCullLightPosition4;
float4 TESR_ShadowCullLightPosition5;
float4 TESR_ShadowCullLightPosition6;
float4 TESR_ShadowCullLightPosition7;
float4 TESR_ShadowCullLightPosition8;
float4 TESR_ShadowCullLightPosition9;
float4 TESR_ShadowCullLightPosition10;
float4 TESR_ShadowCullLightPosition11;
float4 TESR_ShadowCullLightPosition12;
float4 TESR_ShadowCullLightPosition13;
float4 TESR_ShadowCullLightPosition14;
float4 TESR_ShadowCullLightPosition15;
float4 TESR_ShadowCullLightPosition16;
float4 TESR_ShadowCullLightPosition17;
float4 TESR_SunAmount;
float4 TESR_ShadowLightDir;
float4 TESR_ReciprocalResolution;
float4 TESR_ShadowBiasDeferred;

sampler2D TESR_RenderedBuffer : register(s0) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };
sampler2D TESR_DepthBuffer : register(s1) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };
sampler2D TESR_ShadowMapBufferNear : register(s2) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };
sampler2D TESR_ShadowMapBufferFar : register(s3) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };
sampler2D TESR_SourceBuffer : register(s4) = sampler_state { ADDRESSU = CLAMP; ADDRESSV = CLAMP; MAGFILTER = LINEAR; MINFILTER = LINEAR; MIPFILTER = LINEAR; };

static const float nearZ = TESR_ProjectionTransform._43 / TESR_ProjectionTransform._33;
static const float farZ = (TESR_ProjectionTransform._33 * nearZ) / (TESR_ProjectionTransform._33 - 1.0f);
static const float Zmul = nearZ * farZ;
static const float Zdiff = farZ - nearZ;

struct VSOUT
{
	float4 vertPos : POSITION;
	float4 normal : TEXCOORD1;
	float2 UVCoord : TEXCOORD0;
};

struct VSIN
{
	float4 vertPos : POSITION0;
	float2 UVCoord : TEXCOORD0;
};

VSOUT FrameVS(VSIN IN)
{
	VSOUT OUT = (VSOUT)0.0f;
	OUT.vertPos = IN.vertPos;
	OUT.UVCoord = IN.UVCoord;
	return OUT;
}

float readDepth(in float2 coord : TEXCOORD0)
{
	float posZ = tex2D(TESR_DepthBuffer, coord).x;
	posZ = Zmul / ((posZ * Zdiff) - farZ);
	return posZ;
}

float3 toWorld(float2 tex)
{
	float3 v = float3(TESR_ViewTransform[0][2], TESR_ViewTransform[1][2], TESR_ViewTransform[2][2]);
	v += (1 / TESR_ProjectionTransform[0][0] * (2 * tex.x - 1)).xxx * float3(TESR_ViewTransform[0][0], TESR_ViewTransform[1][0], TESR_ViewTransform[2][0]);
	v += (-1 / TESR_ProjectionTransform[1][1] * (2 * tex.y - 1)).xxx * float3(TESR_ViewTransform[0][1], TESR_ViewTransform[1][1], TESR_ViewTransform[2][1]);
	return v;
}

float3 getPosition(in float2 tex, in float depth)
{
	return (TESR_CameraPosition.xyz + toWorld(tex) * depth);
}

float4 getNormals(float2 UVCoord)
{
	float depth = readDepth(UVCoord);
	float3 pos = getPosition(UVCoord, depth);

	float3 left = pos - getPosition(UVCoord + TESR_ReciprocalResolution.xy * float2(-1, 0), readDepth(UVCoord + TESR_ReciprocalResolution.xy * float2(-1, 0)));
	float3 right = getPosition(UVCoord + TESR_ReciprocalResolution.xy * float2(1, 0), readDepth(UVCoord + TESR_ReciprocalResolution.xy * float2(1, 0))) - pos;
	float3 up = pos - getPosition(UVCoord + TESR_ReciprocalResolution.xy * float2(0, -1), readDepth(UVCoord + TESR_ReciprocalResolution.xy * float2(0, -1)));
	float3 down = getPosition(UVCoord + TESR_ReciprocalResolution.xy * float2(0, 1), readDepth(UVCoord + TESR_ReciprocalResolution.xy * float2(0, 1))) - pos;
	float3 dx = length(left) < length(right) ? left : right;
	float3 dy = length(up) < length(down) ? up : down;
	float3 norm = normalize(cross(dx, dy));

	norm.z *= -1;

	return float4((norm + 1) / 2, 1);
}


float LookupFar(float4 ShadowPos, float2 OffSet) {
	float Shadow = tex2D(TESR_ShadowMapBufferFar, ShadowPos.xy + float2(OffSet.x * TESR_ShadowData.w, OffSet.y * TESR_ShadowData.w)).r;
	if (Shadow < ShadowPos.z - TESR_ShadowBiasDeferred.w) return TESR_ShadowData.y;
	return clamp(TESR_ShadowLightDir.w, TESR_ShadowData.y, 1.0f);
}

float GetLightAmountFar(float4 ShadowPos) {

	float Shadow = 0.0f;
	float x;
	float y;

	ShadowPos.xyz /= ShadowPos.w;
	if (ShadowPos.x < -1.0f || ShadowPos.x > 1.0f ||
		ShadowPos.y < -1.0f || ShadowPos.y > 1.0f ||
		ShadowPos.z < 0.0f || ShadowPos.z > 1.0f)
		return 1.0f;

	ShadowPos.x = ShadowPos.x * 0.5f + 0.5f;
	ShadowPos.y = ShadowPos.y * -0.5f + 0.5f;
	for (x = -0.5f; x <= 0.5f; x += 0.5f) {
		for (y = -0.5f; y <= 0.5f; y += 0.5f) {
			Shadow += LookupFar(ShadowPos, float2(x, y));
		}
	}
	Shadow /= 9.0f;
	return Shadow;

}

float Lookup(float4 ShadowPos, float2 OffSet, float bias) {
	float Shadow = tex2D(TESR_ShadowMapBufferNear, ShadowPos.xy + float2(OffSet.x * TESR_ShadowData.z, OffSet.y * TESR_ShadowData.z)).r;
	if (Shadow < ShadowPos.z - bias) return TESR_ShadowData.y;
	return clamp(TESR_ShadowLightDir.w, TESR_ShadowData.y, 1.0f);
}

float AddProximityLight(float4 WorldPos, float4 ExternalLightPos) {

	if (ExternalLightPos.w) {
		float distToExternalLight = distance(WorldPos.xyz, ExternalLightPos.xyz);
		return (saturate(1.000f - (distToExternalLight / (ExternalLightPos.w))));
	}
	return 0.0f;
}


float GetLightAmount(float4 WorldPos, float4 ShadowPos, float4 ShadowPosFar, float bias) {

	float Shadow = 0.0f;
	float x;
	float y;
	float distToExternalLight;

	ShadowPos.xyz /= ShadowPos.w;
	if (ShadowPos.x < -1.0f || ShadowPos.x > 1.0f ||
		ShadowPos.y < -1.0f || ShadowPos.y > 1.0f ||
		ShadowPos.z < 0.0f || ShadowPos.z > 1.0f)
		return GetLightAmountFar(ShadowPosFar);

	ShadowPos.x = ShadowPos.x * 0.5f + 0.5f;
	ShadowPos.y = ShadowPos.y * -0.5f + 0.5f;

	for (y = -2.5f; y <= 2.5f; y += 1.0f) {
		for (x = -2.5f; x <= 2.5f; x += 1.0f) {
			Shadow += Lookup(ShadowPos, float2(x, y), bias);
		}
	}
	Shadow /= 36.0f;

	Shadow += AddProximityLight(WorldPos, TESR_ShadowLightPosition0);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowLightPosition1);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowLightPosition2);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowLightPosition3);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowLightPosition4);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowLightPosition5);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowLightPosition6);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowLightPosition7);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowLightPosition8);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowLightPosition9);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowLightPosition10);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowLightPosition11);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowCullLightPosition0);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowCullLightPosition1);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowCullLightPosition2);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowCullLightPosition3);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowCullLightPosition4);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowCullLightPosition5);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowCullLightPosition6);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowCullLightPosition7);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowCullLightPosition8);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowCullLightPosition9);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowCullLightPosition10);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowCullLightPosition11);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowCullLightPosition12);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowCullLightPosition13);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowCullLightPosition14);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowCullLightPosition15);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowCullLightPosition16);
	Shadow += AddProximityLight(WorldPos, TESR_ShadowCullLightPosition17);
	return saturate(Shadow);

}

float4 Shadow(VSOUT IN) : COLOR0{

	float3 color = tex2D(TESR_RenderedBuffer, IN.UVCoord).rgb;

	if (length(color) > 1.4f) {
		return float4(color, 1.0f);
	}

	float depth = readDepth(IN.UVCoord);
	float3 camera_vector = toWorld(IN.UVCoord) * depth;
	float4 world_pos = float4(TESR_CameraPosition.xyz + camera_vector, 1.0f);

	if (world_pos.z > 1.0f) {
		float4 pos = mul(world_pos, TESR_WorldViewProjectionTransform);
		float4 farPos = pos;
		float4 world_pos_trans = mul(world_pos, TESR_WorldTransform);
		float4 normal = getNormals(IN.UVCoord);
		float4 lightDir = abs(TESR_ShadowLightDir);

		float3 n = normalize(normal);
		float3 l = normalize(lightDir);
		float cosTheta = clamp(dot(n, l), 0, 1);
		float bias = TESR_ShadowBiasDeferred.z * tan(acos(cosTheta));

		pos.xyz = pos.xyz + (normal.xyz * TESR_ShadowBiasDeferred.x);
		farPos.xyz = farPos.xyz + (normal.xyz * TESR_ShadowBiasDeferred.y);
		float4 ShadowNear = mul(pos, TESR_ShadowCameraToLightTransformNear);
		float4 ShadowFar = mul(farPos, TESR_ShadowCameraToLightTransformFar);
		float Shadow = GetLightAmount(world_pos_trans, ShadowNear, ShadowFar, bias);
		color.rgb *= Shadow * float3(1.0f, 1.0f, 1.0f);
	}
	return float4(color, 1.0f);

}

technique {

	pass {
		VertexShader = compile vs_3_0 FrameVS();
		PixelShader = compile ps_3_0 Shadow();
	}

}
