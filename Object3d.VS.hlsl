#include "Object3d.hlsli"

// 定数バッファ（変換行列）
struct TransformationMatrix
{
    float4x4 WVP; // World-View-Projection行列
    float4x4 World; // ワールド行列
    float4x4 WorldInverseTranspose; // ワールド行列の逆転置行列
};

ConstantBuffer<TransformationMatrix> gTransformationMatrix : register(b0);

// 入力頂点構造体
struct VertexShaderInput
{
    float4 position : POSITION0; // 頂点位置
    float2 texcoord : TEXCOORD0; // テクスチャ座標
    float3 normal : NORMAL0; // 法線
};

// 出力構造体
struct VertexShaderOutput
{
    float4 position : SV_POSITION; // クリップ空間での位置
    float2 texcoord : TEXCOORD0; // テクスチャ座標
    float3 normal : NORMAL0; // 法線（ワールド座標系）
    float3 worldPosition : TEXCOORD1; // ワールド空間での位置
};

VertexShaderOutput main(VertexShaderInput input)
{
    VertexShaderOutput output;

    // クリップ空間での位置を計算 (WVP行列を使用)
    output.position = mul(input.position, gTransformationMatrix.WVP);

    // テクスチャ座標はそのままパスする
    output.texcoord = input.texcoord;

    // 法線の座標系をワールド空間に変換し、正規化して出力
    output.normal = normalize(mul(input.normal, (float3x3) gTransformationMatrix.WorldInverseTranspose));

    // ワールド空間での頂点位置を計算
    output.worldPosition = mul(input.position, gTransformationMatrix.World).xyz;

    return output;
}
