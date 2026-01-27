// ピクセルシェーダーの入力
struct PS_INPUT
{
    float4 Position : SV_POSITION; // 座標( プロジェクション空間 )
    float4 Diffuse : COLOR0; // ディフューズカラー
    float2 TexCoords0 : TEXCOORD0; // テクスチャ座標
};
// 定数バッファ：スロット0番目(b0と書く)
cbuffer cbParam : register(b0)
{
    float4 g_color;
    float g_division;
    float g_level; // ベイヤーレベル
    float g_img_sizeX; // 画像サイズX
    float g_img_sizeY; // 画像サイズ
   
}

// ベイヤー配列
static const int BayerPattern[16] =
{
    0, 8, 2, 10,
    12, 4, 14, 6,
    3, 11, 1, 9,
     15, 7, 13, 5
};

// 描画するテクスチャ
Texture2D g_SrcTexture : register(t0);
// サンプラー：適切な色を決める処理
SamplerState g_SrcSampler : register(s0);



float4 main(PS_INPUT psInput) : SV_TARGET
{
    
    // UV基準
    int x = round(psInput.TexCoords0.x * g_img_sizeX);
    int y = round(psInput.TexCoords0.y * g_img_sizeY);
    int dither = (x % 4) + (y % 4 * 4);
    
   
    
    //todo
    if (int(g_level) > BayerPattern[dither])
    {
        discard;
    }
    // UV座標とテクスチャを参照して、最適な色を取得する
    float4 srcCol = g_SrcTexture.Sample(g_SrcSampler, psInput.TexCoords0);
    if (srcCol.a < 0.01f)
    {
    // 描画しない
        discard;
    }
    return srcCol  * g_color;
    
    
    
}

